//
//  ChatRoomService.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/7/24.
//

import Foundation
import Combine

protocol ChatRoomServiceType {
    func createChatRoomIfNeeded(myUserID: String, otherUserID: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError>
    func loadChatRooms(myUserID: String) -> AnyPublisher<[ChatRoom], ServiceError>
}

class ChatRoomService: ChatRoomServiceType {
    private let dbRepository: ChatRoomDBRepositoryType
    
    init(dbRepository: ChatRoomDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func createChatRoomIfNeeded(myUserID: String, otherUserID: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError> {
        dbRepository.getChatRoom(myUserID: myUserID, otherUserID: otherUserID)
            .mapError { ServiceError.error($0) }
            .flatMap { object in
                if let object {
                    return Just(object.toModel()).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
                } else {
                    let newChatRoom: ChatRoom = .init(chatRoomID: UUID().uuidString, otherUserName: otherUserName, otherUseID: otherUserID)
                    return self.addChatRoom(newChatRoom, to: myUserID)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func addChatRoom(_ chatRoom: ChatRoom, to myUserID: String) -> AnyPublisher<ChatRoom, ServiceError> {
        dbRepository.addChatRoom(chatRoom.toObject(), myUserId: myUserID)
            .map { chatRoom }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func loadChatRooms(myUserID: String) -> AnyPublisher<[ChatRoom], ServiceError> {
        dbRepository.loadChatRoom(myUserID: myUserID)
            .map { $0.map { $0.toModel() } }
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
}

class StubChatRoomService: ChatRoomServiceType {
    func createChatRoomIfNeeded(myUserID: String, otherUserID: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError> {
        Just(.stub1).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func loadChatRooms(myUserID: String) -> AnyPublisher<[ChatRoom], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
}
