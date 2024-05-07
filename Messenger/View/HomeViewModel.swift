//
//  HomeViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/23/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum Action {
        case load
        case requestContacts
        case isPresentMyProfileView
        case isPresentOtherProfileView(String)
        case goToChat(User)
    }
    
    @Published var myUser: User?
    @Published var users: [User] = []
    @Published var phase: Phase = .notRequested
    @Published var modalDestination: HomeModalDestination?
    
    var userID: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            phase = .loading
            
            container.services.userService.getUser(userID: userID)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(id: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
        case .requestContacts:
            container.services.contactService.fetchContacts()
                .flatMap { users in
                    self.container.services.userService.addUserAfterContact(users: users)
                }
                .flatMap { _ in
                    self.container.services.userService.loadUsers(id: self.userID)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)

            
        case .isPresentMyProfileView:
            modalDestination = .myProfile
            
        case let .isPresentOtherProfileView(userID):
            modalDestination = .otherProfile(userID)
            
        case let .goToChat(otherUser):
            container.services.chatRoomService.createChatRoomIfNeeded(myUserID: userID, otherUserID: otherUser.id, otherUserName: otherUser.name)
                .sink { completion in
                    
                } receiveValue: { chatRoom in
                    
                }.store(in: &subscriptions)
        }
    }
}
