//
//  URLImageViewModel.swift
//  Messenger
//
//  Created by YUJIN KWON on 5/6/24.
//

import UIKit
import Combine

class URLImageViewModel: ObservableObject {
    var loadingOrSuccess: Bool {
     return isLoading || loadedImage != nil
    }
    
    @Published var loadedImage: UIImage?
    
    private var isLoading: Bool = false
    private var container: DIContainer
    private var urlString: String
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, urlString: String) {
        self.container = container
        self.urlString = urlString
    }
    
    func start() {
        guard !urlString.isEmpty else { return }
        
        isLoading = true
        
        container.services.imageCacheService.image(for: urlString)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.isLoading = false
                self?.loadedImage = image
            }.store(in: &subscriptions)
    }
}
