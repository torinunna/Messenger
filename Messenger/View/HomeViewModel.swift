//
//  HomeViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/23/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [.stub1, .stub2, .stub3]
}
