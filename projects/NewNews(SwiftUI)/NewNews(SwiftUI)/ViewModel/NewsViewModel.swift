//
//  NewsViewModel.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import Foundation
import Combine

protocol NewsViewModelProtocol {
    func getArticles()
    var isLoading: Bool { get }
}

final class NewsViewModel: ObservableObject, NewsViewModelProtocol {
    private let service: NewsService
    
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    var isLoading: Bool {
        state == .loading
    }
    
    init(service: NewsService) {
        self.service = service
    }
    
    
    func getArticles() {
        self.state = .loading
        
        let cancellable = service
            .request(from: .getNews)
            .sink { completion in
                switch completion {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        
        self.cancellables.insert(cancellable)
    }
}
