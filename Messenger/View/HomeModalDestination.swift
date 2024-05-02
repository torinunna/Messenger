//
//  HomeModalDestination.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/2/24.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id: Int {
        hashValue
    }
}
