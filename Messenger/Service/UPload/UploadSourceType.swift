//
//  UploadSourceType.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/5/24.
//

import Foundation

enum UploadSourceType {
    case chat(chatRoomID: String)
    case profile(userID: String)
    
    var path: String {
        switch self {
        case let .chat(chatRoomID):
            return "\(DBKey.Chats)/\(chatRoomID)"
        case let .profile(userID):
            return "\(DBKey.Users)/\(userID)"
        }
    }
}
