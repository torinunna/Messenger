//
//  MyProfileView.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/2/24.
//

import SwiftUI

struct MyProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MyProfileViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    profileView
                        .padding(.bottom, 15)
                    
                    nameView
                        .padding(.bottom, 26)
                    
                    descriptionView
                    
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
    
    var profileView: some View {
        Button {
            
        } label: {
            Image("person")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        }
    }
    
    var nameView: some View {
        Text(viewModel.userInfo?.name ?? "이름")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.bgWh)
    }
    
    var descriptionView: some View {
        Button {
            viewModel.isPresentedDescEditView.toggle()
        } label: {
            Text(viewModel.userInfo?.description ?? "상태메세지를 입력해주세요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.bgWh)
        }
        .sheet(isPresented: $viewModel.isPresentedDescEditView) {
            MyProfileDescEditView(description: viewModel.userInfo?.description ?? "") { willBeDesc in
                Task {
                    await viewModel.updateDescription(willBeDesc)
                }
            }
        }
    }
    
    var menuView: some View {
        HStack(alignment: .top, spacing: 27) {
            ForEach(MyProfileMenuType.allCases, id: \.self) { menu in
                VStack {
                    Button {
                        
                    } label: {
                        VStack(alignment: .center) {
                            Image(menu.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text(menu.description)
                                .font(.system(size: 10))
                                .foregroundStyle(Color.bgWh)
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    MyProfileView(viewModel: .init(container: DIContainer(services: StubService()), userID: "user1_id"))
}
