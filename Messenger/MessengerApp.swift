//
//  MessengerApp.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/15/24.
//

import SwiftUI

@main
struct MessengerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView(authViewModel: .init(container: container), navigationRouter: .init())
                .environmentObject(container)
        }
    }
}
