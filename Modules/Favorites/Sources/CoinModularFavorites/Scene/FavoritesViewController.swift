//
//  FavoritesViewController.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import UIKit
import CommonsModel
import CommonsData


public class FavoritesViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var favorites = [FavoriteCoin]()
    var coins = [Coin]()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Moeda Digital"
        label.font = UIFont(name: "AvenirNext-Medium", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        let dateTimeString = formatter.string(from: currentDateTime)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = dateTimeString
        label.font = UIFont(name: "AvenirNext-Medium", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.addSeparator()
        return label
    }()
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        // Adicionar a chamada da api aqui para sempre atualizar as chamadas
        let repository = FavoriteCoinRepository()
        let coinsRepository = CoinsRemoteRepository()
        coinsRepository.fetchCoinsFavorites(
            coinsFavorites: repository.getFavoritesCoinsFormatedString(),
            completion: { coins in
                self.coins = coins
                self.collectionView.reloadData()
                debugPrint(coins)
            })
        
        debugPrint("RELOAD")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
        
        self.configureUICollectionView()
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        self.setUpTitleConstraints()
        let repository = FavoriteCoinRepository()
        let coinsRepository = CoinsRemoteRepository()
        coinsRepository.fetchCoinsFavorites(
            coinsFavorites: repository.getFavoritesCoinsFormatedString(),
            completion: { coins in
                self.coins = coins
                self.configureUICollectionView()
                self.setUpCollectionViewConstraints()
                self.setUpSubtitleConstraints()
                debugPrint(coins)
            })
        
    }
    
    private func configureUICollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.self.size.width/2) - 30,
                                 height: CGFloat(120))
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        collectionView.register(FavoriteCollectionViewCell.self,
                                forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        self.view.addSubview(collectionView)
    }
    
    private func setUpTitleConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setUpSubtitleConstraints() {
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setUpCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 20),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        let coin = self.coins[indexPath.row]
        cell.titleLabel.text = coin.name
        cell.subtitleLabel.text = coin.assetID
        
        let priceUsd: Double? = coin.priceUsd
        if priceUsd != nil {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: priceUsd! as NSNumber) {
                cell.value.text = "\(formattedTipAmount)"
            }
        }
        else {
            cell.value.text = "$0.00"
        }
        
        if coin.idIcon != nil {
            debugPrint(
                "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(coin.idIcon!).png")
            cell.iconCoin.load(url: URL(string: "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/\(coin.idIcon!.replacingOccurrences(of: "-", with: "")).png"))
        }
        
        return cell
    }
    
    public override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        return CGSize(width: (view.frame.self.size.width/2) - 30,
                      height: CGFloat(120))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Item selecionado: \(coins[indexPath.item].assetID)")
        if self.navigationController != nil {
            let detailsCoordinator = FavoritesCoordinator(navigationController: self.navigationController!)
            detailsCoordinator.navigateToDetails(coinId: coins[indexPath.item].assetID)
        }
    }
    
    @discardableResult
    func addSeparator() -> UIView {
        let view = UIView()
        let insets: UIEdgeInsets = .zero
        let weight: CGFloat = 1.0 / UIScreen.main.scale
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: insets.left).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -insets.right).isActive = true
        view.heightAnchor.constraint(equalToConstant: weight).isActive = true
        return view
    }
}

