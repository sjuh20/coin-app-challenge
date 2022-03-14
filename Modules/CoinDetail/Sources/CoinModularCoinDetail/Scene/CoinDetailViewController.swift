//
//  CoinDetailViewController.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import UIKit
import CommonsData

public class CoinDetailViewController: UIViewController {
    
    var coinId: String!
    var detalhesScrenn: CoinDetailView?
    
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
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.detalhesScrenn?.delegate(delegate: self)
    }
}

extension CoinDetailViewController: CoinDetailProtocol{
    
    func actionBackButton() {
        print("Back Button !!")
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionAddButton() {
        
    }
    
}

