//
//  DetalhesScrenn.swift
//  CoinAppChallenge
//
//  Created by Natanael Alves Pereira on 08/03/22.
//

import UIKit
import CommonsModel

protocol CoinDetailProtocol: AnyObject{
    func actionBackButton()
    func actionAddButton(coinId: String)
    func actionRemoveButton(coinId: String)
}

class CoinDetailView: UIView {
    
    weak var delegate: CoinDetailProtocol?
    var coinId: String?
    var isFavorite: Bool = false
    
    func delegate(delegate: CoinDetailProtocol?){
        self.delegate = delegate
    }
    
    func setCoinId(coinId: String) {
        self.coinId = coinId
    }
    
    func setIsFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    public var viewPreta: DetalhesViewBlack = {
        let view = DetalhesViewBlack()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Voltar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let imageBack = UIImage(named: "back")
        imageBack?.withTintColor(UIColor.white)
        button.setImage(imageBack, for: .normal)
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .white
        name.font = UIFont.boldSystemFont(ofSize: 14)
        name.text = "BTC"
        return name
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
        button.addTarget(self, action: #selector(self.tappedAdicionarButton), for: .touchUpInside)
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
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView(){
        self.addSubview(self.estrelaImage)
        self.addSubview(self.backButton)
        self.addSubview(self.moedaImage)
        self.addSubview(self.adicionarButton)
        self.addSubview(self.nameLabel)
        self.addSubview(self.valorLabel)
        self.addSubview(self.viewPreta)
    }
    
    private func configBackGround(){
        self.backgroundColor = UIColor(red: 141/255, green: 149/255, blue: 98/255, alpha: 1.0)
    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedAdicionarButton(sender: UIButton!){
        
        if !isFavorite {
            adicionarButton.setTitle("Adicionar", for: .normal)
            estrelaImage.isHidden = true
            self.delegate?.actionAddButton(coinId: self.coinId ?? "")
        }else{
            adicionarButton.setTitle("Remover", for: .normal)
            estrelaImage.isHidden = false
            self.delegate?.actionRemoveButton(coinId: self.coinId ?? "")
            
        }
    }
    
    // MARK: - Define as constraints
    
    func setData(coin: Coin) {
        self.nameLabel.text = coin.name
        
        let priceUsd: Double? = coin.priceUsd
        if priceUsd != nil {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: priceUsd! as NSNumber) {
                self.valorLabel.text = "\(formattedTipAmount)"
            }
        }
        else {
            self.valorLabel.text = "$0.00"
        }
        
        if coin.idIcon != nil {
            debugPrint(
                "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(coin.idIcon!).png")
            self.moedaImage.load(url: URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(coin.idIcon!.replacingOccurrences(of: "-", with: "")).png"))
        }
        
        self.viewPreta.setData(coin: coin)
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.backButton.topAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            self.moedaImage.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 35),
            self.moedaImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            self.moedaImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.moedaImage.heightAnchor.constraint(equalToConstant: 50),
            
            self.valorLabel.topAnchor.constraint(equalTo: self.moedaImage.bottomAnchor, constant: 10),
            self.valorLabel.centerXAnchor.constraint(equalTo: self.nameLabel.centerXAnchor),
            self.valorLabel.heightAnchor.constraint(equalToConstant: 70),
            
            self.adicionarButton.topAnchor.constraint(equalTo: self.valorLabel.bottomAnchor, constant: 20),
            self.adicionarButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
            self.adicionarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -30),
            self.adicionarButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.viewPreta.topAnchor.constraint(equalTo: self.adicionarButton.bottomAnchor, constant: 40),
            self.viewPreta.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.viewPreta.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.viewPreta.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.estrelaImage.bottomAnchor.constraint(equalTo: self.moedaImage.topAnchor, constant: 5),
            self.estrelaImage.trailingAnchor.constraint(equalTo: self.adicionarButton.trailingAnchor),
            self.estrelaImage.widthAnchor.constraint(equalToConstant: 20),
            self.estrelaImage.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}

extension UIImageView {
    func load(url: URL?) {
        DispatchQueue.global().async { [weak self] in
            if url == nil {
                debugPrint("Vazio")
            } else if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
