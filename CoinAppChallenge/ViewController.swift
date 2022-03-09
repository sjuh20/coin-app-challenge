//
//  ViewController.swift
//  CryptoTrack
//
//  Created by Jonathan Pereira Almeida on 08/03/22.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier:CryptoTableViewCell.identifier)
        return tableView
    }()
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        
        return formatter
    }()
    
    //MARK: -  search

    
    
    
    
    
    //MARK: - finish search
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " Cryptomoedas"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        APICaller.shared.getAllCryptoData {[weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({ model in
                
                    let price = model.price_usd ?? 0
                    let formatter = ViewController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    
                    let iconUrl = URL (string: APICaller.shared.icons.filter({ icon in
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
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)

        }

    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int ) -> Int {
        return viewModels.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier, for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}


