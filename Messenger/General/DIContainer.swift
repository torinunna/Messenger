//
//  DIContainer.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/20/24.
//

import Foundation

class DIContainer:  ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
