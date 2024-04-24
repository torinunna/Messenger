//
//  HomeView.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/23/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                profileView
                    .padding(.bottom, 30)
                
                searchBtn
                    .padding(.bottom, 24)
                
                HStack {
                    Text("친구")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.bkText)
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                if viewModel.users.isEmpty {
                    Spacer(minLength: 89)
                    emptyview
                } else {
                    ForEach(viewModel.users, id: \.id) { user in
                        HStack(spacing: 8) {
                            Image("person")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Text(user.name)
                                .font(.system(size: 12))
                                .foregroundStyle(Color.bkText)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
            .toolbar {
                Image("bookmark")
                Image("notifications")
                Image("person_add")
                Button {
                    
                } label: {
                    Image("settings")
                }
            }
        }
    }
    
    var profileView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color.bkText)
                Text(viewModel.myUser?.description ?? "상태 메세지")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.greyDeep)
            }
            
            Spacer()
            
            Image("person")
                .resizable()
                .frame(width: 52, height: 52)
                .clipShape(Circle())
        }
        .padding(.horizontal, 30)
    }
    
    var searchBtn: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(height: 36)
                .background(Color.greyCool)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack {
                Text("검색")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.greyLightVer2)
                Spacer()
            }
            .padding(.leading, 22)
        }
        .padding(.horizontal, 30)
    }
    
    var emptyview: some View {
        VStack {
            VStack(spacing: 3) {
                Text("친구를 추가해보세요.")
                    .foregroundStyle(Color.bkText)
                
                Text("QR코드나 검색을 이용해서 친구를 추가해보세요.")
                    .foregroundStyle(Color.greyDeep)
            }
            .font(.system(size: 14))
            .padding(.bottom, 30)
            
            Button {
                
            } label: {
                Text("친구추가")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.bkText)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}
