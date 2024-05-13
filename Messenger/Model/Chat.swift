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
    
    var lastMessage: String {
        if let message {
            return message
        } else if let _ = photoURL {
            return "사진"
        } else {
            return "내용없음"
        }
    }
}

extension Chat {
    func toObject() -> ChatObject {
        .init(chatID: chatID,
              userID: userID,
              message: message,
              photoURL: photoURL,
              date: date.timeIntervalSince1970)
    }
}
