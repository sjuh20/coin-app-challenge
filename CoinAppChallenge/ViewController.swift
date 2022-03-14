//
//  ViewController.swift
//  CryptoTrack
//
//  Created by Jonathan Pereira Almeida on 08/03/22.
//

import UIKit





    
    var isSearch = false


    private let tableView: UITableView = {

        let tableView = UITableView(frame: .zero , style: .plain)

        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier:CryptoTableViewCell.identifier)


        tableView.backgroundColor = .black


        //        tableView.backgroundColor = .black
        return tableView

    }()

    

    var viewModels : [CryptoTableViewCellViewModel] = []
  //  var filterdTableData = viewModels

    static let numberFormatter: NumberFormatter = {

        let formatter = NumberFormatter()

        formatter.locale = .current

        formatter.allowsFloats = true

        formatter.numberStyle = .currency

        formatter.formatterBehavior = .default

        

        return formatter

    }()


    override var prefersPointerLocked: Bool {

        return true

    }

    override var preferredStatusBarStyle: UIStatusBarStyle{

        return .lightContent

    }

=======
    
    //MARK: -  search
    
    //MARK: - finish search
        
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
    override func viewDidLoad() {

        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.dataSource = self

        tableView.delegate = self

        constraintsTableView()



    //    navigationController?.navigationBar.isHidden = true
        
        lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
        searchBar.delegate = self
        searchBar.placeholder = " Search for a coin ... "
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
          self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        
        
        APICaller.shared.getAllCryptoData {[weak self] result in

            switch result {

            case .success(let models):

                self?.viewModels = models.compactMap({ model in
<<<<<<< HEAD

                

=======
                    
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
                    let price = model.price_usd ?? 0

                    let formatter = ViewController.numberFormatter

                    let priceString = formatter.string(from: NSNumber(value: price))

                    let iconUrl = URL (string: APICaller.shared.icons.filter({ icon in

                        icon.asset_id == model.asset_id

                    }).first?.url ?? "")

                    
<<<<<<< HEAD

                  return CryptoTableViewCellViewModel(

=======
                    return CryptoTableViewCellViewModel(
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
                        name:model.name ?? "N/A",

                        symbol:model.asset_id,

                        price: priceString ?? "N/A",

                        iconUrl: iconUrl

                    )
<<<<<<< HEAD

=======
                    
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
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

//        tableView.frame = view.bounds

    }
    func constraintsTableView() {


        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
<<<<<<< HEAD
//    override func viewDidAppear(_ animated: Bool) {

//        self.navigationController?.navigationBar.tintColor = .clear

//

//        }



=======
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        self.navigationController?.navigationBar.tintColor = .clear
    //
    //        }
    
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
    // TableView

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let headerView = UIView.init(frame: CGRect.init(x: 10, y: 0, width: tableView.frame.width, height: 70))

        headerView.backgroundColor = .black

            let label = UILabel()

        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width, height: headerView.frame.height-30)
            label.textAlignment = .center
            label.text = "Moeda Digital"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .white
            headerView.addSubview(label)

            return headerView

        }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 50

        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int ) -> Int {

        return viewModels.count

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
<<<<<<< HEAD



//        self.navigationController?.pushViewController(detalhes, animated: true)

=======
        
//        self.navigationController?.pushViewController(detalhes, animated: true)
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
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

    // MARK: Search Bar

extension ViewController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
               isSearch = true
        }
           
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               isSearch = false
        }
           
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               isSearch = false
        }
           
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               isSearch = false
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.count == 0 {
                isSearch = false
                self.tableView.reloadData()
            } else {
                for i in 0...viewModels.count {
                    if viewModels[i].name.lowercased().contains(searchText.lowercased()) {viewModels.remove(at: i)}
                }
                
            }
                if(viewModels.count == 0){
                    isSearch = false
                } else {
                    isSearch = true
                }
                self.tableView.reloadData()
            }
        }
 

