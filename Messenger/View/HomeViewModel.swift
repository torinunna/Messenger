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
        case getUser
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
        case .getUser:
            container.services.userService.getUser(userID: userID)
                .sink { completion in
                    
                } receiveValue: { [weak self] user in
                    self?.myUser = user
                }.store(in: &subscriptions)
        }
    }
}
