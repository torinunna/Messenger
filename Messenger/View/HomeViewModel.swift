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
    @Published var phase: Phase = .notRequested
    
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
        }
    }
}
