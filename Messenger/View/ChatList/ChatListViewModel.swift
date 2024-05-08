//
//  ChatListViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/9/24.
//

import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    enum Action {
     case load
    }
    
    @Published var chatRooms: [ChatRoom] = []

    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    let userID: String
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            container.services.chatRoomService.loadChatRooms(myUserID: userID)
                .sink { completion in
                    
                } receiveValue: { [weak self] chatRooms in
                    self?.chatRooms = chatRooms
                }.store(in: &subscriptions)
        }
    }
}

