//
//  UserService.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/26/24.
//

import Foundation

protocol UserServiceType {
    
}

class UserService: UserServiceType {
    private var dbRepository: UserDBRepository
    
    init(dbRepository: UserDBRepository) {
        self.dbRepository = dbRepository
    }
}

class StubUserService: UserServiceType {
    
}
