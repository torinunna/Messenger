//
//  PhotosPickerService.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/5/24.
//

import SwiftUI
import PhotosUI
import Combine

enum PhotosPickerError: Error {
    case importFailed
}

protocol PhotosPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data
    func loadTransferable(from imageSelection: PhotosPickerItem) -> AnyPublisher<Data, ServiceError>
}

class PhotosPickerService: PhotosPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        guard let image = try await imageSelection.loadTransferable(type: PhotoImage.self) else {
            throw PhotosPickerError.importFailed
        }
        return image.data
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem) -> AnyPublisher<Data, ServiceError> {
        Future { promise in
            imageSelection.loadTransferable(type: PhotoImage.self) { result in
                switch result {
                case let .success(image):
                    guard let data = image?.data else {
                        promise(.failure(PhotosPickerError.importFailed))
                        return
                    }
                    promise(.success(data))
                    
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .mapError { .error($0) }
        .eraseToAnyPublisher()
    }
}
    
    class StubPhotosPickerService: PhotosPickerServiceType {
        func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
            return Data()
        }
        
        func loadTransferable(from imageSelection: PhotosPickerItem) -> AnyPublisher<Data, ServiceError> {
            Empty().eraseToAnyPublisher()
        }
    }

