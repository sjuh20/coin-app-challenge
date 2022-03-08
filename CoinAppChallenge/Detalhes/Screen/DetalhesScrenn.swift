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
    
    lazy var moedaImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage (named:  "bitcoin")
        image.contentMode = .scaleAspectFit

        return image
    }()
    
    lazy var valorLabel:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 24)
        valor.text = "$ 31.010.20"
        
        return valor
    }()
    
    lazy var adicionarButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor(red: 141/255, green: 149/255, blue: 98/255, alpha: 1.0)
//        button.addTarget(self, action: #selector(self.tappedregisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var estrelaImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage (named:  "estrela")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    private func configSuperView(){
        self.addSubview(self.estrelaImage)
        self.addSubview(self.backButton)
        self.addSubview(self.moedaImage)
        self.addSubview(self.adicionarButton)
        self.addSubview(self.nomeLabel)
        self.addSubview(self.valorLabel)
        
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
