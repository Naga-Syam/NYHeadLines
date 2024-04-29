//
//  ViewModel.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import Foundation

class NewsViewModel {
    
    var docs: [Docs] = []
    
    var eventHandler: ((_ event: Event) -> Void)?
        
    func fetchNews() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: NewsResponse.self,
            type: NewsEndPoint.news) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let newsResponse):
                    self.docs = newsResponse.response?.docs ?? []
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

extension NewsViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
