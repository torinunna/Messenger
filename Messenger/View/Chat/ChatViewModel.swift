//
//  ChatViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/10/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    enum Action {
        
    }
    
    @Published var chatDataList: [ChatData] = []
    @Published var myUser: User?
    @Published var otherUSer: User?
    @Published var message: String = ""
    
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
        
    }
}


