//
//  ChatRoom.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/7/24.
//

import Foundation

struct ChatRoom: Codable {
    var chatRoomID: String
    var lastMessage: String?
    var otherUserName: String
    var otherUseID: String
}

extension ChatRoom {
    func toObject() -> ChatRoomObject {
        .init(chatRoomID: chatRoomID,
              lastMessage: lastMessage,
              otherUserName: otherUserName,
              otherUseID: otherUseID)
        
    }
}
