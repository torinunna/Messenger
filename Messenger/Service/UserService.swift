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
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError>
    func getUser(userID: String) -> AnyPublisher<User, ServiceError>
    func getUser(userID: String) async throws -> User
    func updateDescription(userID: String, description: String) async throws
    func updateUserProfileURL(userID: String, urlString: String) async throws
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError>
}

class UserService: UserServiceType {
    private var dbRepository: UserDBRepositoryType
    
    init(dbRepository: UserDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        dbRepository.addUser(user.toObject())
            .map { user }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        dbRepository.addUserAfterContact(users: users.map { $0.toObject() })
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userID: String) -> AnyPublisher<User, ServiceError> {
        dbRepository.getUser(userId: userID)
            .map { $0.toModel() }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userID: String) async throws -> User {
        let userObject = try await dbRepository.getUser(userID: userID)
        return userObject.toModel()
    }
    
    func updateDescription(userID: String, description: String) async throws {
        try await dbRepository.updateUser(userID: userID, key: "description", value: description)
    }
    
    func updateUserProfileURL(userID: String, urlString: String) async throws {
        try await dbRepository.updateUser(userID: userID, key: "profileURL", value: urlString)
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
    
    func addUserAfterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUser(userID: String) -> AnyPublisher<User, ServiceError> {
        Just(.stub1).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func getUser(userID: String) async throws -> User {
        return .stub1
    }
    
    func updateDescription(userID: String, description: String) async throws {
        
    }
    
    func updateUserProfileURL(userID: String, urlString: String) async throws {
        
    }
    
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
}
