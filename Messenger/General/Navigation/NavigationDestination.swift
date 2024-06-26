//
//  NavigationDestination.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/7/24.
//

import Foundation

enum NavigationDestination: Hashable {
    case chat(ChatRoomID: String, myUserID: String, otherUserID: String)
    case search
}
