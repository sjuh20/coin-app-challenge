//
//  ViewController.swift
//  CryptoTrack
//
//  Created by Jonathan Pereira Almeida on 08/03/22.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    lazy var detalhes:DetalhesVc = DetalhesVc()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier:CryptoTableViewCell.identifier)
//        tableView.backgroundColor = .black
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
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        constraintsTableView()
        navigationController?.navigationBar.isHidden = true
        
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
    
    func constraintsTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.tintColor = .clear
//
//        }

    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int ) -> Int {
        return viewModels.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigationController?.pushViewController(detalhes, animated: true)
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
        return 90
    }
    
}



