//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 11/03/22.
//

import Foundation
import CommonsModel
import UIKit

public struct CoinsRemoteRepository {
    
    public init() {
        
    }
    
    private let ASSETS_FILTER_URL: String = "https://rest.coinapi.io/v1/assets?filter_asset_id="
    private let ASSETS_URL: String = "https://rest.coinapi.io/v1/assets/"
    
    public func fetchCoinsFavorites(coinsFavorites: String, completion: @escaping([Coin]) -> Void) {

        guard let url = URL(string: "\(ASSETS_FILTER_URL + coinsFavorites)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("AEA7C6F6-4FCA-4C45-901E-BF07DD7741B7", forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao consumir o servico: ", error)
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let coins = try JSONDecoder().decode([Coin].self, from: data)
                    completion(coins)
                } catch {
                    debugPrint(error)
                }
            }
        }.resume()
        
    }
    
    public func fetchCoinById(coinId: String, completion: @escaping(Coin) -> Void) {
    
        guard let url = URL(string: "\(ASSETS_URL + coinId)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("AEA7C6F6-4FCA-4C45-901E-BF07DD7741B7", forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao consumir o servico: ", error)
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let coin = try JSONDecoder().decode([Coin].self, from: data)
                    if coin.first == nil {
                        return
                    }
                    completion(coin.first!)
                } catch {
                    debugPrint(error)
                }
            }
        }.resume()
    }
    
}
