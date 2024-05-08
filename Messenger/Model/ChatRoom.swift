//
//  ChatRoom.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/7/24.
//

import Foundation

struct ChatRoom: Hashable {
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

extension ChatRoom {
    static var stub1: ChatRoom {
        .init(chatRoomID: "chatRoom1_id", otherUserName: "권토리", otherUseID: "user1_id")
    }
    
    static var stub2: ChatRoom {
        .init(chatRoomID: "chatRoom2_id", otherUserName: "권베베", otherUseID: "user2_id")
    }
    
    static var stub3: ChatRoom {
        .init(chatRoomID: "chatRoom3_id", otherUserName: "홍꾸꾸", otherUseID: "user3_id")
    }
}
