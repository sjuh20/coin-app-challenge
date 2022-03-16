//
//  CryptoTableViewCell.swift
//  CryptoTrack
//
//  Created by Jonathan Pereira Almeida on 08/03/22.


import UIKit
import CommonsData

struct CryptoTableViewCellViewModel{
    let name: String
    let symbol: String
    let price: String
    let iconUrl: URL?
}

class CryptoTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoTableViewCell"
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let starImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(nameLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height/1.1
        iconImageView.frame = CGRect(x: 20, y: (contentView.frame.size.height-size)/2 , width: 55, height: 55)
        
        nameLabel.sizeToFit()
        starImageView.sizeToFit()
        priceLabel.sizeToFit()
        symbolLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 10 + size, y: 10, width: nameLabel.frame.size.width, height: 15)
        starImageView.frame = CGRect(x: nameLabel.frame.size.width, y: 10, width: contentView.frame.size.width/2, height: 15)
        symbolLabel.frame = CGRect(x: 10 + size, y: nameLabel.frame.size.height + 25, width: contentView.frame.size.width/2, height: 15)
        priceLabel.frame = CGRect(x: contentView.frame.size.width/2, y: 0, width: (contentView.frame.size.width/2)-15, height: 40)
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        nameLabel.text = nil
        symbolLabel.text = nil
        priceLabel.text = nil
        starImageView.isHidden = true
    }
    func configure(with viewModel: CryptoTableViewCellViewModel){
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        symbolLabel.text = viewModel.symbol
        
        let repository = FavoriteCoinRepository()
        let isFavorite = repository.coinContainsInFavoritesById(coinId: viewModel.symbol)
        
        self.starImageView.isHidden = !isFavorite
        
        
        if viewModel.iconUrl?.absoluteString == nil {
            self.iconImageView.image = UIImage(named: "bitcoin")
        } else
        
        if let url = viewModel.iconUrl {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.iconImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
    
}

