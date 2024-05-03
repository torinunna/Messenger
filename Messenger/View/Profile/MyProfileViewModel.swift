//
//  MyProfileViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/3/24.
//

import Foundation

class MyProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    
    private let userID: String
    private var container: DIContainer
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
}
