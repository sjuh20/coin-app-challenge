//
//  CoinsView.swift
//  
//
//  Created by Natanael Alves Pereira on 15/03/22.
//

import UIKit

class CoinsView: UIView, UISearchBarDelegate {

    lazy var tituloLabel:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 21)
        valor.text = "Moeda Digital"
        
        return valor
    }()
    
    lazy var dataLabel:UILabel = {
        let valor = UILabel()
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
       
       let dateTimeString = formatter.string(from: currentDateTime)
        let label = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = dateTimeString
        
        return valor
    }()
    
    lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
       searchBar.translatesAutoresizingMaskIntoConstraints = false
       searchBar.searchBarStyle = .default
       searchBar.placeholder = " Search..."
       searchBar.sizeToFit()
       searchBar.barTintColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0)
       searchBar.isTranslucent = false
       searchBar.delegate = self
       return searchBar

     }()
    
    private func configCoinsView(){
        addSubview(tituloLabel)
        addSubview(dataLabel)
        addSubview(searchBar)
        searchBar.delegate = self
    }
    
    private func setUpConstraintsView(){
        NSLayoutConstraint.activate([
            
            
            self.tituloLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tituloLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            
            self.dataLabel.topAnchor.constraint(equalTo: self.tituloLabel.bottomAnchor, constant: 10),
            self.dataLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//
            self.searchBar.topAnchor.constraint(equalTo: self.dataLabel.bottomAnchor,constant: 20),
            self.searchBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.searchBar.widthAnchor.constraint(equalToConstant: 320),
            self.searchBar.heightAnchor.constraint(equalToConstant: 60)
            
        ])}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.configCoinsView()
        self.setUpConstraintsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
