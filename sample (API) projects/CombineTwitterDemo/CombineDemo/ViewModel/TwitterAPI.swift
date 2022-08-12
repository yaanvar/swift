//
//  TwitterAPI.swift
//  CombineDemo
//
//  Created by Anvar Rahimov on 12.08.2022.
//

import Foundation
import STTwitter
import Combine

struct TwitterAPI {
    
    let key = "xxxx"
    let secret = "xxxx"
    var api: STTwitterAPI
    
    init() {
        api = STTwitterAPI(appOnlyWithConsumerKey: key, consumerSecret: secret)
    }
    
    func verifyCredentials() -> Future<(String?, String?), Error> {
        Future { promise in
            api.verifyCredentials(userSuccessBlock: { userName, userId in
                promise(.success((userName, userId)))
            }, errorBlock: { error in
                promise(Result.failure(error!))
            })
        }
    }
    
    func getSearchTweet(with query: String) -> AnyPublisher<[Tweet], Error> {
        Future { promise in
            api.getSearchTweets(withQuery: query) { data, res in
                promise(.success(res))
            } errorBlock: { error in
                promise(Result.failure(error!))
            }
        }
        .compactMap({ $0 })
        .tryMap {
            try JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted)
        }
        .decode(type: [Tweet].self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
    }
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
}

