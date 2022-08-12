//
//  TwitterViewModel.swift
//  CombineDemo
//
//  Created by Anvar Rahimov on 12.08.2022.
//

import Foundation
import STTwitter
import Combine

class TwitterViewModel {
    
    var tweets = CurrentValueSubject<[Tweet], Never>([Tweet]())
    
    var searchText = CurrentValueSubject<String, Never>("Paul Hudson")
    
    let twitterAPI = TwitterAPI()
    var subscription = Set<AnyCancellable>()
    
    init() {
        twitterAPI.verifyCredentials()
            .sink { completion in
                switch completion {
                case .failure(let error): print("error occured: \(error.localizedDescription)")
                case .finished: break
                }
                
            } receiveValue: { [weak self] (_, _) in
                print("success")
                self?.setupFetchTweets()
            }.store(in: &subscription)
        
    }
    
    func setupFetchTweets() {
        searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { [unowned self] (searchText) -> AnyPublisher<[Tweet], Never> in
                
                self.twitterAPI.getSearchTweet(with: searchText)
                    .catch { (error) in
                        Just([Tweet]())
                    }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink { [unowned self] (tweets) in
                self.tweets.send(tweets)
            }.store(in: &subscription)
        
    }
}
