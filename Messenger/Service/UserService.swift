//
//  UserService.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/26/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>
    func getUser(userID: String) -> AnyPublisher<User, ServiceError>
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError>
}

class UserService: UserServiceType {
    private var dbRepository: UserDBRepository
    
    init(dbRepository: UserDBRepository) {
        self.dbRepository = dbRepository
    }
    
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        dbRepository.addUser(user.toObject())
            .map { user }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userID: String) -> AnyPublisher<User, ServiceError> {
        dbRepository.getUser(userId: userID)
            .map { $0.toModel() }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError> {
        dbRepository.loadUsers()
            .map { $0
                .map { $0.toModel() }
                .filter { $0.id != id }
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}

class StubUserService: UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUser(userID: String) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
}
