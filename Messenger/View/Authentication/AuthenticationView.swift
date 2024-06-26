//
//  AuthenticationView.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/15/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    @StateObject var navigationRouter: NavigationRouter

    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationRouter)
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
    }
}

#Preview {
    AuthenticationView(authViewModel: .init(container: .init(services: StubService())), navigationRouter: .init())
}
