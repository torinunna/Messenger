//
//  ChatData.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/10/24.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
