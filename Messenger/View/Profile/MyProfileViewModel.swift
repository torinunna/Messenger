//
//  MyProfileViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/3/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class MyProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    @Published var isPresentedDescEditView: Bool = false
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                await updateProfileImage(pickerItem: imageSelection)
            }
        }
    }
    
    private let userID: String
    private var container: DIContainer
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userID: userID) {
            userInfo = user
        }
    }
    
    func updateDescription(_ description: String) async {
        do {
            try await container.services.userService.updateDescription(userID: userID, description: description)
            userInfo?.description = description
        } catch {
            
        }
    }
    
    func updateProfileImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem else {  return }
        
        do {
            let data = try await container.services.photosPickerService.loadTransferable(from: pickerItem)
            let url = try await container.services.uploadService.uploadImage(source: .profile(userID: userID), data: data)
            try await container.services.userService.updateUserProfileURL(userID: userID, urlString: url.absoluteString)
            
            userInfo?.profileURL = url.absoluteString
        } catch {
            print(error.localizedDescription)
        }
    }
}
