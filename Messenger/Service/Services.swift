//
//  Services.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/20/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    var userService: UserServiceType { get set }
    var contactService: ContactServiceType { get set }
    var photosPickerService: PhotosPickerServiceType { get set }
    var uploadService: UploadServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    var contactService: ContactServiceType
    var photosPickerService: PhotosPickerServiceType
    var uploadService: UploadServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository())
        self.contactService = ContactService()
        self.photosPickerService = PhotosPickerService()
        self.uploadService = UploadService(provider: UploadProvider())
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var contactService: ContactServiceType = StubContactService()
    var photosPickerService: PhotosPickerServiceType = PhotosPickerService()
    var uploadService: UploadServiceType = StubUploadService()
}
