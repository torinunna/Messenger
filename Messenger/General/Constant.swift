//
//  Constant.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/26/24.
//

import Foundation

typealias DBKey = Constant.DBKey

enum Constant { }

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}
