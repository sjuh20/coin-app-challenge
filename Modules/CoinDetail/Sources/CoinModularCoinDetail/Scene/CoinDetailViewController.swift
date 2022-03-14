//
//  CoinDetailViewController.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import UIKit

public class CoinDetailViewController: UIViewController {

    var coinId: String!
    var detalhesScrenn: DetalhesScrenn?
    
    public init(coinId : String) {
        super.init(nibName: nil, bundle: nil)
        self.coinId = coinId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func loadView() {
        self.detalhesScrenn = DetalhesScrenn()
        self.view = self.detalhesScrenn
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.detalhesScrenn?.delegate(delegate: self)
    }
}

extension CoinDetailViewController: DetalhesScreenProtocol{
    
    func actionBackButton() {
        print("Back Button !!")
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionAdicionarButton() {
        
    }
    
}

