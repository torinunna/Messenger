//
//  AuthenticationView.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/15/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authViewModel: AutenticationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    AuthenticationView(authViewModel: .init())
}
