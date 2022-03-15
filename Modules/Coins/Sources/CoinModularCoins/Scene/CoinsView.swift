//
//  CoinsView.swift
//  
//
//  Created by Natanael Alves Pereira on 15/03/22.
//

import UIKit

class CoinsView: UIView {

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

}
