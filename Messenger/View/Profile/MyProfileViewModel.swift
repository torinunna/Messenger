//
//  MyProfileViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/3/24.
//

import Foundation


@MainActor
class MyProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    @Published var isPresentedDescEditView: Bool = false
    
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
    
    func updateDescription(_ description: String) async {
        do {
            try await container.services.userService.updateDescription(userID: userID, description: description)
            userInfo?.description = description
        } catch {
            
        }
    }
}
