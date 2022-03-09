//
//  DetalhesVc.swift
//  CoinAppChallenge
//
//  Created by Natanael Alves Pereira on 08/03/22.
//

import UIKit

class DetalhesVc: UIViewController {

    var detalhesScrenn: DetalhesScrenn?
    override func loadView() {
        self.detalhesScrenn = DetalhesScrenn()
        self.view = self.detalhesScrenn
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detalhesScrenn?.delegate(delegate: self)
    }


}


extension DetalhesVc: DetalhesScreenProtocol{
    func actionBackButton() {
        print("Back Button !!")
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionAdicionarButton() {
        
    }
    
    
}
