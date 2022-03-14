//
//  File.swift
//  
//
//  Created byAna Brito Souza on 10/03/22.
//

import Foundation
import CommonsModel

public class FavoriteCoinRepository {
    
    func getFavoritesCoinsFormatedString() -> String {
        let _favoritesCoins: [FavoriteCoin] = getFavoriteCoins()
        return _favoritesCoins.map({(nota:FavoriteCoin) -> String in
            return nota.assetID
        }).joined(separator: ";")
    }
    
    func getFavoriteCoins() -> [FavoriteCoin] {
        var favoritesCoins = [FavoriteCoin]()
        
        if let storedObject: Data = UserDefaults.standard.data(forKey: "favorites_coins") {
            do
            {
                favoritesCoins = try PropertyListDecoder().decode([FavoriteCoin].self, from: storedObject)
                for favoriteCoin in favoritesCoins
                {
                    debugPrint(favoriteCoin.assetID)
                }
            }
            catch
            {
                print(error.localizedDescription)
                return []
            }
        }
        
        return favoritesCoins
    }
    
    func addFavoriteCoins(favoriteCoin: FavoriteCoin) {
        var favoritesCoins = getFavoriteCoins()
        favoritesCoins.append(favoriteCoin)
        saveFavoritesCoins(favoritesCoins: favoritesCoins)
        
    }
    
    func removeFavoriteCoins(favoriteCoin: FavoriteCoin) {
        var favoritesCoins = getFavoriteCoins()
        if let index = favoritesCoins.firstIndex(where: {$0.assetID == favoriteCoin.assetID}) {
            debugPrint(index)
            favoritesCoins.remove(at: index)
        } else {
            return
        }
        saveFavoritesCoins(favoritesCoins: favoritesCoins)
    }
    
    func clearFavoritesCoins() {
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
