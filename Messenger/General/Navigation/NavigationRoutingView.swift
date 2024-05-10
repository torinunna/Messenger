//
//  NavigationRoutingView.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/9/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case let .chat(chatroomID, myUserID, otherUserID):
            ChatView(viewModel: .init(container: container, chatRoomID: chatroomID, myUserID: myUserID, otherUserID: otherUserID))
        case .search:
            SearchView()
        }
    }
}
