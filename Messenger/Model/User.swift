//
//  User.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/22/24.
//

import Foundation

struct User {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}

extension User {
    func toObject() -> UserObject {
        .init(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            profileURL: profileURL,
            description: description
        )
    }
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "권토리")
    }
    
    static var stub2: User {
        .init(id: "user2_id", name: "권베베")
    }
    
    static var stub3: User {
        .init(id: "user3_id", name: "홍꾸꾸")
    }
}
