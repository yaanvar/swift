//
//  Coin.swift
//  DesignCode
//
//  Created by Anvar Rahimov on 20.08.2022.
//

import SwiftUI

struct Coin: Identifiable, Codable {
    var id: Int
    var coin_name: String
    var acronym: String
    var logo: String
}

class CoinModel: ObservableObject {
    @Published var coins: [Coin] = []
    
    @MainActor
    func fetchCoins() async {
        do {
            guard let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10") else { return }
            
            let(data, _) = try await URLSession.shared.data(from: url)
            
            coins = try JSONDecoder().decode([Coin].self, from: data)
        } catch {
            print("error")
        }
    }
}
