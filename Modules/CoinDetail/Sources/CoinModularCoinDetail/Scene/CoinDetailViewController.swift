//
//  CoinDetailViewController.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import UIKit
import CommonsData
import CommonsModel

public class CoinDetailViewController: UIViewController {
    
    var coinId: String!
    var detalhesScrenn: CoinDetailView?
    var repository: FavoriteCoinRepository?
    
    public init(coinId : String) {
        super.init(nibName: nil, bundle: nil)
        self.coinId = coinId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func loadView() {
        self.detalhesScrenn = CoinDetailView()
        self.view = self.detalhesScrenn
        
        let coinsRepository = CoinsRemoteRepository()
        coinsRepository.fetchCoinById(
            coinId: self.coinId,
            completion: { coin in
                debugPrint(coin)
                self.detalhesScrenn?.setData(coin: coin)
            })
        
        let result = repository?.coinContainsInFavoritesById(coinId: self.coinId)
        self.detalhesScrenn?.setIsFavorite(isFavorite: result ?? false)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.detalhesScrenn?.delegate(delegate: self)
        self.detalhesScrenn?.setCoinId(coinId: coinId)
        
        repository = FavoriteCoinRepository()
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension CoinDetailViewController: CoinDetailProtocol{
    
    func actionBackButton() {
        print("Back Button !!")
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionAddButton(coinId:String) {
        self.repository?.addFavoriteCoins(favoriteCoin: FavoriteCoin(coinId))
    }
    
    func actionRemoveButton(coinId: String) {
        self.repository?.removeFavoriteCoins(favoriteCoin: FavoriteCoin(coinId))
    }
}

