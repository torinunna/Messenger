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
    }
    
    @Published var myUser: User?
    @Published var users: [User] = []
    
    private var userID: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            container.services.userService.getUser(userID: userID)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(id: user.id)
                }
                .sink { completion in
                    
                } receiveValue: { [weak self] users in
                    self?.users = users
                }.store(in: &subscriptions)
        }
    }
}
