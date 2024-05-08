//
//  NavigationRouter.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/7/24.
//

import Foundation

class NavigationRouter: ObservableObject {
    @Published var destinations: [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
    
    func popToRootView() {
        destinations = []
    }
}
