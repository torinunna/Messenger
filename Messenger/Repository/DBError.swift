//
//  DBError.swift
//  Messenger
//
//  Created by YUJIN KWON on 4/26/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
}
