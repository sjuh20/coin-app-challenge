//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 10/03/22.
//

import Foundation
import CommonsModel

public class FavoriteCoinRepository {
    
    public init() {
        
    }
    
    public func getFavoritesCoinsFormatedString() -> String {
        let _favoritesCoins: [FavoriteCoin] = getFavoriteCoins()
        return _favoritesCoins.map({(nota:FavoriteCoin) -> String in
            return nota.assetID
        }).joined(separator: ";")
    }
    
    public func getFavoriteCoins() -> [FavoriteCoin] {
        var favoritesCoins = [FavoriteCoin]()
        
        if let storedObject: Data = UserDefaults.standard.data(forKey: "favorites_coins") {
            do {
                favoritesCoins = try PropertyListDecoder().decode([FavoriteCoin].self, from: storedObject)
            }
            catch {
                print(error.localizedDescription)
                return []
            }
        }
        
        return favoritesCoins
    }
    
    public func addFavoriteCoins(favoriteCoin: FavoriteCoin) {
        var favoritesCoins = getFavoriteCoins()
        favoritesCoins.append(favoriteCoin)
        saveFavoritesCoins(favoritesCoins: favoritesCoins)
    }
    
    public func coinContainsInFavoritesById(coinId: String) -> Bool {
        let favoritesCoins = getFavoriteCoins()
        return favoritesCoins.contains(where: { $0.assetID == coinId })
    }
    
    public func removeFavoriteCoins(favoriteCoin: FavoriteCoin) {
        var favoritesCoins = getFavoriteCoins()
        if let index = favoritesCoins.firstIndex(where: {$0.assetID == favoriteCoin.assetID}) {
            favoritesCoins.remove(at: index)
        } else {
            return
        }
        saveFavoritesCoins(favoritesCoins: favoritesCoins)
    }
    
    public func clearFavoritesCoins() {
        UserDefaults.standard.removeObject(forKey: "favorites_coins")
        UserDefaults.standard.synchronize()
    }
    
    private func saveFavoritesCoins(favoritesCoins: [FavoriteCoin]) {
        do
        {
            UserDefaults.standard.set(try PropertyListEncoder().encode(favoritesCoins), forKey: "favorites_coins")
            UserDefaults.standard.synchronize()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}
