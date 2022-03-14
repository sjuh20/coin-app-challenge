//
//  DetalhesScrenn.swift
//  CoinAppChallenge
//
//  Created by Natanael Alves Pereira on 08/03/22.
//

import UIKit

protocol DetalhesScreenProtocol: AnyObject{
    func actionBackButton()
    func actionAdicionarButton()
}

class DetalhesScrenn: UIView {

    weak var delegate:DetalhesScreenProtocol?
    
    func delegate(delegate:DetalhesScreenProtocol?){
        self.delegate = delegate
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
        self.addSubview(self.nomeLabel)
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
        self.delegate?.actionAdicionarButton()
        if !estrelaImage.isHidden{
            adicionarButton.setTitle("Adicionar", for: .normal)
            estrelaImage.isHidden = true
            
        }else{
        adicionarButton.setTitle("Remover", for: .normal)
        estrelaImage.isHidden = false
        }
    }
    
    // MARK: - Define as constraints
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
        
            self.nomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.nomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            self.backButton.topAnchor.constraint(equalTo: self.nomeLabel.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            self.moedaImage.topAnchor.constraint(equalTo: self.nomeLabel.bottomAnchor, constant: 35),
            self.moedaImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            self.moedaImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.moedaImage.heightAnchor.constraint(equalToConstant: 50),
            
            self.valorLabel.topAnchor.constraint(equalTo: self.moedaImage.bottomAnchor, constant: 10),
            self.valorLabel.centerXAnchor.constraint(equalTo: self.nomeLabel.centerXAnchor),
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
