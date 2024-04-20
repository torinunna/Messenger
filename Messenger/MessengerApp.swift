//
//  MessengerApp.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/15/24.
//

import SwiftUI

@main
struct MessengerApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView(authViewModel: .init())
                .environmentObject(container)
        }
    }
}
