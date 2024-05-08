//
//  OtherProfileView.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/2/24.
//

import SwiftUI

struct OtherProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: OtherProfileViewModel
    
    var goToChat: (User) -> Void
   
    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)
                
                VStack {
                    Spacer()
                    
                    URLImageView(urlString: viewModel.userInfo?.profileURL)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.bottom, 16)
                    
                    Text(viewModel.userInfo?.name ?? "이름")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.bgWh)
                    
                    Spacer()
                    
                    menuView
                        .padding(.bottom, 58)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                    }
                }
            }
            .task {
                await viewModel.getUser()
            }
        }
    }
  
    var menuView: some View {
        HStack(alignment: .top, spacing: 50) {
            ForEach(OtherProfileMenuType.allCases, id: \.self) { menu in
                VStack {
                    Button {
                        if menu == .chat, let userInfo = viewModel.userInfo {
                            dismiss()
                            goToChat(userInfo)
                        }
                    } label: {
                        VStack(alignment: .center) {
                            Image(menu.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text(menu.description)
                                .font(.system(size: 10))
                                .foregroundColor(.whiteFix)
                        }
                    }
                }
            }
            
        }
    }

}

#Preview {
    OtherProfileView(viewModel: .init(container: DIContainer(services: StubService()), userID: "user1_id")) { _ in
    }
}
