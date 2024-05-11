//
//  ChatService.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/11/24.
//

import Foundation
import Combine

protocol ChatServiceType {
    func addChat(_ chat: Chat, to chatRoomID: String) -> AnyPublisher<Chat, ServiceError>
    func observeChat(chatRoomID: String) -> AnyPublisher<Chat?, Never>
}

class ChatService: ChatServiceType {
    private let dbRepository: ChatDBRepositoryType
    
    init(dbRepository: ChatDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func addChat(_ chat: Chat, to chatRoomID: String) -> AnyPublisher<Chat, ServiceError> {
        var chat = chat
        chat.chatID = dbRepository.childByAutoID(chatRoomID: chatRoomID)
        return dbRepository.addChat(chat.toObject(), to: chatRoomID)
            .map { chat }
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
    
    func observeChat(chatRoomID: String) -> AnyPublisher<Chat?, Never> {
        dbRepository.observeChat(chatRoomID: chatRoomID)
            .map { $0?.toModel() }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

class StubChatService: ChatServiceType {
    func addChat(_ chat: Chat, to chatRoomID: String) -> AnyPublisher<Chat, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func observeChat(chatRoomID: String) -> AnyPublisher<Chat?, Never> {
        Empty().eraseToAnyPublisher()
    }
}
