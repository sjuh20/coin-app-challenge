//
//  CoinsViewController.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation
import UIKit
import CommonsProtocols
import CommonsData
import CoinModularCoinDetail


public class CoinsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isSearch = false
    var dadosFiltrados = [CryptoTableViewCellViewModel]()
    
    lazy var coinsView: CoinsView = {
        let view = CoinsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero , style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier:CryptoTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    public  override var prefersPointerLocked: Bool {
        return true
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getAllIcons()
        coinsView.searchBar.delegate = self
        view.addSubview(coinsView)
        view.addSubview(tableView)
        coinsView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        
        constraintsTableView()
        
        APICaller.shared.getAllCryptoData {[weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({ model in
                    let price = model.price_usd ?? 0
                    let formatter = CoinsViewController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    let iconUrl = URL(string: APICaller.shared.icons.filter({ icon in
                        icon.asset_id == model.asset_id
                    }).first?.url ?? "")
                    return CryptoTableViewCellViewModel(
                        name:model.name ?? "N/A",
                        symbol:model.asset_id,
                        price: priceString ?? "N/A",
                        iconUrl: iconUrl
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    public  override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func constraintsTableView() {
        coinsView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        coinsView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        coinsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coinsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coinsView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        tableView.topAnchor.constraint(equalTo: coinsView.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int ) -> Int {
        
        if isSearch {
            return dadosFiltrados.count
        }else {
            return viewModels.count
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.navigationController != nil {
            CoinsCoordinator(navigationController: self.navigationController!).navigateToDetails(coinId: viewModels[indexPath.row].symbol)
        } else{return} 
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier, for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        if isSearch {
            cell.configure(with: dadosFiltrados[indexPath.row])
            
        }else {
            cell.configure(with: viewModels[indexPath.row])
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension CoinsViewController:UISearchBarDelegate{
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false
            self.tableView.reloadData()
        } else {
            dadosFiltrados = self.viewModels.filter({(coin) -> Bool in
                let tmp: NSString = coin.name as NSString
                let range = tmp.range(of: searchText, options:NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        }
        if(dadosFiltrados.count == 0){
            isSearch = false
        } else {
            isSearch = true
        }
        self.tableView.reloadData()
    }
}





