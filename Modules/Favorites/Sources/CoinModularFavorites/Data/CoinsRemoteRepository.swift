//
//  File.swift
//  
//
//  Created by Gustavo Jesus Gomes on 11/03/22.
//

import Foundation
import CommonsModel

enum ResultCoins {
    case success(coins: [Coin])
    case failure(error: Error)
}

enum Error {
    case parseError(error: String)
}

struct CoinsRemoteRepository {
    
    func fetchGenreMovies(coinsFavorites: String, completion: @escaping() -> Void) {
        let coins = [Coin]()
        guard let url = URL(string: "https://rest.coinapi.io/v1/assets?filter_asset_id=\(coinsFavorites)"
        ) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("68C87D3E-C615-4C5E-A080-5995DE794D2E", forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                print(response)
                print(String(data: data!, encoding: .utf8))
            }
        }.resume()
        
    }
}
