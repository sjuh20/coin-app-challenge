//
//  DetalhesScrenn.swift
//  CoinAppChallenge
//
//  Created by Natanael Alves Pereira on 08/03/22.
//

import UIKit

class DetalhesScrenn: UIView {

    lazy var backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Voltar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let imageBack = UIImage(named: "back")
        imageBack?.withTintColor(UIColor.white)
        button.setImage(imageBack, for: .normal)
//        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var nomeLabel:UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.textColor = .white
        nome.font = UIFont.boldSystemFont(ofSize: 14)
        nome.text = "BTC"
        return nome
    }()
    
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
