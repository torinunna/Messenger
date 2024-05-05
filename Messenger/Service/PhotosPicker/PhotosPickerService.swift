//
//  PhotosPickerService.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/5/24.
//

import Foundation
import SwiftUI
import PhotosUI

enum PhotosPickerError: Error {
    case importFailed
}

protocol PhotosPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data
}

class PhotosPickerService: PhotosPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        guard let image = try await imageSelection.loadTransferable(type: PhotoImage.self) else {
            throw PhotosPickerError.importFailed
        }
        return image.data
    }
}

class StubPhotosPickerService: PhotosPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        return Data()
    }
}
