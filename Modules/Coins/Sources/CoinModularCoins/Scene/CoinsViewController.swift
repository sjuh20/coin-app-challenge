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
  //  var filterdTableData = viewModels
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getAllIcons()
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
    
  public  override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    //        tableView.frame = view.bounds
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
    
    
   public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 10, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = .black
            let label = UILabel()
        label.frame = CGRect.init(x: 5, y: -5, width: headerView.frame.width, height: headerView.frame.height-30)
            label.textAlignment = .center
            label.text = "Moeda Digital"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .white
       
       let labelData = UILabel()
       labelData.frame = CGRect.init(x: 1, y: 15, width: headerView.frame.width, height: headerView.frame.height-10)
       
       let currentDateTime = Date()
       let formatter = DateFormatter()
       formatter.dateStyle = .medium
      
      let dateTimeString = formatter.string(from: currentDateTime)
       labelData.textAlignment = .center
       labelData.text =  dateTimeString
       labelData.font = .systemFont(ofSize: 16)
       labelData.textColor = .white
       
            headerView.addSubview(label)
            headerView.addSubview(labelData)
            return headerView

        }

   public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int ) -> Int {
        return viewModels.count
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier, for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension CoinsViewController:UISearchBarDelegate{

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
     //           for i in 0...viewModels.count {
    //            if viewModels[i].name.lowercased().contains(searchText.lowercased()) {viewModels.remove(at: i)}
    //            }
            }
                if(viewModels.count == 0){
                    isSearch = false
                } else {
                    isSearch = true
                }
                self.tableView.reloadData()
            }
        }


   




