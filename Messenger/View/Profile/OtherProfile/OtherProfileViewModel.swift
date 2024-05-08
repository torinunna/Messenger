//
//  OtherProfileViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/6/24.
//

import Foundation

@MainActor
class OtherProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    
    private let userID: String
    private var container: DIContainer
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userID: userID) {
            userInfo = user
        }
    }
}
