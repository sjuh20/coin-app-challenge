//
//  APICaller.swift
//  CryptoTrack
//
//  Created by Jonathan Pereira Almeida on 08/03/22.
//

import Foundation

final class APICaller{
  static let shared = APICaller()
  
  public var icons: [Icon] = []
  
  private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
  
  private struct Constants{
    static let APIKey = "3C42F2CC-6D84-49A8-8C19-ABA1268338CB"
    static let assetsEndPoint = "https://rest-sandbox.coinapi.io/v1/assets/"
  }
//https://rest-sandbox.coinapi.io/v1/assets/icons/55/?apikey=F66BC9E3-1683-4988-BBCD-D684ECDDD6BE
//https://rest.coinapi.io/v1/assets/icons/55/?apikey=F66BC9E3-1683-4988-BBCD-D684ECDDD6BE
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
    guard let url = URL(string: "https://rest.coinapi.io/v1/assets/icons/55/?apikey=F66BC9E3-1683-4988-BBCD-D684ECDDD6BE") else { return }
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



