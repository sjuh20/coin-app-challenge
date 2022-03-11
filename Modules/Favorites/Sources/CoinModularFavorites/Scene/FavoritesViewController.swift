//
//  FavoritesViewController.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import UIKit
import CommonsModel

public class FavoritesViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var favorites = [FavoriteCoin]()
    
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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4 jan 2020"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.addSeparator()
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
        
        self.configureUICollectionView()
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        self.setUpTitleConstraints()
        self.setUpSubtitleConstraints()
        self.setUpCollectionViewConstraints()
        
        let repository = FavoriteCoinRepository()
        
        repository.clearFavoritesCoins()
        
        let coin1 = FavoriteCoin("BTC")
        let coin2 = FavoriteCoin("USD")
        let coin3 = FavoriteCoin("CNY")
        let coin4 = FavoriteCoin("EUR")
        let coin5 = FavoriteCoin("PLN")
        
        
        repository.addFavoriteCoins(favoriteCoin: coin1)
        repository.addFavoriteCoins(favoriteCoin: coin2)
        repository.addFavoriteCoins(favoriteCoin: coin3)
        repository.addFavoriteCoins(favoriteCoin: coin4)
        repository.addFavoriteCoins(favoriteCoin: coin5)
        
        
        self.favorites = repository.getFavoriteCoins()
        
        repository.removeFavoriteCoins(favoriteCoin: coin1)
        self.favorites = repository.getFavoriteCoins()
        
        let coinsRepository = CoinsRemoteRepository()
        coinsRepository.fetchGenreMovies(coinsFavorites: "BTC;USD;PLN;EUR;CNY", completion: {
            debugPrint("chamou")
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

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.titleLabel.text = self.favorites[indexPath.row].assetID
        return cell
    }
    
    public override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        return CGSize(width: (view.frame.self.size.width/2) - 30,
                      height: CGFloat(120))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
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

