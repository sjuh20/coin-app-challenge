//
//  APICaller.swift
//  CryptoTrack
//
//  Created by Jonathan Pereira Almeida on 08/03/22.
//

import Foundation
import CommonsData

final class APICaller{
    static let shared = APICaller()
    
    public var icons: [Icon] = []
    
    private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
    
    private struct Constants{
        static let APIKey = Constantes.API_KEY
        static let assetsEndPoint = "https://rest.coinapi.io/v1/assets/"
    }
    
    private init() {}
    
    public func getAllCryptoData(completion: @escaping (Result<[Crypto], Error>) -> Void){
        
        guard !icons.isEmpty else {
            
            whenReadyBlock = completion
            return
        }
        
        
        guard let url = URL(string: Constants.assetsEndPoint + "?apikey=" + Constants.APIKey) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(cryptos))
                
            }catch{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    
    func getAllIcons(){
        guard let url = URL(string: "https://rest.coinapi.io/v1/assets/icons/55/?apikey=\(Constants.APIKey)") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let completion = self?.whenReadyBlock{
                    self?.getAllCryptoData(completion: completion)
                }
                
            }catch{
                print(error)
            }
            
        }
        task.resume()
    }
    
}



