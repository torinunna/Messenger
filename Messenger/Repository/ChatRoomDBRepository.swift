//
//  ChatRoomDBRepository.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/6/24.
//

import Foundation
import Combine
import FirebaseDatabase

protocol ChatRoomDBRepositoryType {
    func getChatRoom(myUserID: String, otherUserID: String) -> AnyPublisher<ChatRoomObject?, DBError>
    func addChatRoom(_ object: ChatRoomObject, myUserId: String) -> AnyPublisher<Void, DBError>
}

class ChatRoomDBRepository: ChatRoomDBRepositoryType {
    var db: DatabaseReference = Database.database().reference()
    
    func getChatRoom(myUserID: String, otherUserID: String) -> AnyPublisher<ChatRoomObject?, DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.ChatRooms).child(myUserID).child(otherUserID).getData { error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }.flatMap { value in
            if let value {
                return Just(value)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                    .decode(type: ChatRoomObject?.self, decoder: JSONDecoder())
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: .emptyValue).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addChatRoom(_ object: ChatRoomObject, myUserId: String) -> AnyPublisher<Void, DBError> {
        Just(object)
            .compactMap { try? JSONEncoder().encode($0) }
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap { value in
                Future<Void, Error> { [weak self] promise in
                    self?.db.child(DBKey.ChatRooms).child(myUserId).child(object.otherUseID).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError { DBError.error($0) }
            .eraseToAnyPublisher()
    }
}
