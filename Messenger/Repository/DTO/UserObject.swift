//
//  UserObject.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/26/24.
//

import Foundation

struct UserObject: Codable {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}
