//
//  ChatRoomObject.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/6/24.
//

import Foundation

struct ChatRoomObject: Codable {
    var chatRoomID: String
    var lastMessage: String?
    var otherUserName: String
    var otherUseID: String
}

extension ChatRoomObject {
    func toModel() -> ChatRoom {
        .init(chatRoomID: chatRoomID,
              lastMessage: lastMessage,
              otherUserName: otherUserName,
              otherUseID: otherUseID)
    }
}
