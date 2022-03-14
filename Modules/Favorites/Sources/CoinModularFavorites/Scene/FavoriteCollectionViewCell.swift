//
//  FavoriteCollectionViewCell.swift
//  
//
//  Created by Ana Brito Souza on 10/03/22.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bitcoin"
        label.font = UIFont(name: "AvenirNext-Medium", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BTC"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var value: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$ 31.010.20"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var iconCoin: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(value)
        contentView.addSubview(iconCoin)
        
        contentView.backgroundColor = UIColor(red: 141/255, green: 149/255, blue: 98/255, alpha: 1.0)
        contentView.layer.cornerRadius = 12
        
        self.setUpTitleConstraints()
        self.setUpSubtitleConstraints()
        self.setUpValueConstraints()
    }
    
    private func setUpTitleConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private func setUpSubtitleConstraints() {
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private func setUpValueConstraints() {
        NSLayoutConstraint.activate([
            self.value.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor),
            self.value.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.value.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.value.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.value.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        iconCoin.frame = CGRect(x: self.contentView.frame.width - 30,
                                y: self.contentView.frame.minY - 5,
                                width: 36,
                                height: 36)
        
    }
}


extension UIView {
    
    @discardableResult
    func addSeparator() -> UIView {
        let view = UIView()
        let insets: UIEdgeInsets = .zero
        let weight: CGFloat = 1.0 / UIScreen.main.scale
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right).isActive = true
        view.heightAnchor.constraint(equalToConstant: weight).isActive = true
        return view
    }
}
