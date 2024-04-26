//
//  UserDBRepository.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/26/24.
//

import Foundation
import Combine
import FirebaseDatabase

protocol UserDBRepositorytype {
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError>
}

class UserDBRepository: UserDBRepositorytype {
    var db: DatabaseReference = Database.database().reference()
    
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError> {
        
        Just(object)
            .compactMap { try? JSONEncoder().encode($0) }
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap { value in
                Future<Void, Error> { [weak self] promise in
                    self?.db.child(DBKey.Users).child(object.id).setValue(value) { error, _ in
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
