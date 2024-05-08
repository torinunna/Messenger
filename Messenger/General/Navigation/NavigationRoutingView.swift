//
//  NavigationRoutingView.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/9/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .chat:
            ChatView()
        case .search:
            SearchView()
        }
    }
}
