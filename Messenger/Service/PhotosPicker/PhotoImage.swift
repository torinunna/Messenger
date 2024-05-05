//
//  PhotoImage.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/5/24.
//

import SwiftUI

struct PhotoImage: Transferable {
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw PhotosPickerError.importFailed
            }
            
            guard let data = uiImage.jpegData(compressionQuality: 0.3) else {
                throw PhotosPickerError.importFailed
            }
            
            return PhotoImage(data: data)
        }
    }
}
