//
//  ChatViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/10/24.
//

import Combine
import SwiftUI
import PhotosUI

class ChatViewModel: ObservableObject {
    enum Action {
        case load
        case addChat(String)
        case uploadImage(PhotosPickerItem?)
    }
    
    @Published var chatDataList: [ChatData] = []
    @Published var myUser: User?
    @Published var otherUser: User?
    @Published var message: String = ""
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            send(action: .uploadImage(imageSelection))
        }
    }
    
    private let chatRoomID: String
    private let myUserID: String
    private let otherUserID: String
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, chatRoomID: String, myUserID: String, otherUserID: String) {
        self.container = container
        self.chatRoomID = chatRoomID
        self.myUserID = myUserID
        self.otherUserID = otherUserID
        
        bind()
    }
    
    func bind() {
        container.services.chatService.observeChat(chatRoomID: chatRoomID)
            .sink { [weak self] chat in
                guard let chat else { return }
                self?.updateChatDataList(chat)
            }.store(in: &subscriptions)
    }
    
    func updateChatDataList(_ chat: Chat) {
        let key = chat.date.toChatDateKey
        
        if let index = chatDataList.firstIndex(where: { $0.dateStr == key }) {
            chatDataList[index].chats.append(chat)
        } else {
            let newChatData: ChatData = .init(dateStr: key, chats: [chat])
            chatDataList.append(newChatData)
        }
    }
    
    func getDirection(id: String) -> ChatItemDirection {
        myUserID == id ? .right : .left
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            Publishers.Zip(container.services.userService.getUser(userID: myUserID),
                           container.services.userService.getUser(userID: otherUserID))
            .sink { completion in
                
            } receiveValue: { [weak self] myUser, otherUSer in
                self?.myUser = myUser
                self?.otherUser = otherUSer
            }.store(in: &subscriptions)
            
        case let .addChat(message):
            let chat: Chat = .init(chatID: UUID().uuidString, userID: myUserID, message: message, date: Date())
            
            container.services.chatService.addChat(chat, to: chatRoomID)
                .flatMap { chat in
                    self.container.services.chatRoomService.updateChatRoomLastMessage(chatRoomID: self.chatRoomID,
                                                                                      myUserID: self.myUserID,
                                                                                      myUserName: self.myUser?.name ?? "",
                                                                                      otherUserID: self.otherUserID,
                                                                                      lastMessage: chat.lastMessage)
                }
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.message = ""
                }.store(in: &subscriptions)

        case let .uploadImage(pickerItem):
            guard let pickerItem else { return }
            
            container.services.photosPickerService.loadTransferable(from: pickerItem)
                .flatMap { data in
                    self.container.services.uploadService.uploadImage(source: .chat(chatRoomID: self.chatRoomID), data: data)
                }
                .flatMap { url in
                    let chat: Chat = .init(chatID: UUID().uuidString, userID: self.myUserID, photoURL: url.absoluteString, date: Date())
                    return self.container.services.chatService.addChat(chat, to: self.chatRoomID)
                }
                .flatMap { chat in
                    self.container.services.chatRoomService.updateChatRoomLastMessage(chatRoomID: self.chatRoomID,
                                                                                      myUserID: self.myUserID,
                                                                                      myUserName: self.myUser?.name ?? "",
                                                                                      otherUserID: self.otherUserID,
                                                                                      lastMessage: chat.lastMessage)
                }
                .sink { _ in
                    
                } receiveValue: { _ in
                    
                }.store(in: &subscriptions)

        }
    }
}


