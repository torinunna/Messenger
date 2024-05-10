//
//  Chat.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/10/24.
//

import Foundation

struct Chat: Hashable, Identifiable {
    var chatID: String
    var userID: String
    var message: String?
    var photoURL: String?
    var date: Date
    var id: String { chatID }
}
