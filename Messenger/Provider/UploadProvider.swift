//
//  UploadProvider.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/5/24.
//

import Foundation
import FirebaseStorage
import Combine
import FirebaseStorageCombineSwift

enum UploadError: Error {
    case error(Error)
}

protocol UploadProviderType {
    func upload(path: String, data: Data, fileName: String) async throws -> URL
    func upload(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError>
}

class UploadProvider: UploadProviderType {
    let storageRef = Storage.storage().reference()
    
    func upload(path: String, data: Data, fileName: String) async throws -> URL {
        let ref = storageRef.child(path).child(fileName)
        let _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()
        
        return url
    }
    
    func upload(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError> {
        let ref = storageRef.child(path).child(fileName)
        return ref.putData(data)
            .flatMap { _ in
                ref.downloadURL()
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}
