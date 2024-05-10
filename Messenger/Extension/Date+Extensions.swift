//
//  Date+Extensions.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/10/24.
//

import Foundation

extension Date {
    var toChatTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a h:mm"
        return dateFormatter.string(from: self)
    }
    
    var toChatDateKey: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd E"
        return dateFormatter.string(from: self)
    }
}
