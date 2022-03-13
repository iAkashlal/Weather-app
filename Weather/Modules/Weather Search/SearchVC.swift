//
//  SearchVC.swift
//  Weather
//
//  Created by akashlal on 12/03/22.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView! // 1
    
    var viewModel = SearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
    }
    
    private func setupTableView() {
        searchTableView.register(nib: SearchListTVC.self)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        viewModel.reloadUI = { [weak self] in
            self?.searchTableView.reloadData()
        }
    }

}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.performSearch(text: searchText)
    }
    
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTableView.deselectRow(at: indexPath, animated: true)
        if viewModel.isLoading {
            return
        }
        if let location = viewModel.searchResultList?[indexPath.row] {
            print("location with lat\(location.lat) and long \(location.lon) tapped" )
        }
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isLoading {
            return 3
        }
        else {
            return viewModel.searchResultList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchListTVC = searchTableView.dequeueReusableCell(forIndexPath: indexPath)
        if viewModel.isLoading {
            cell.configureAsLoadingCell()
        } else {
            if let location = viewModel.searchResultList?[indexPath.row] {
                cell.configure(for: location)
            }
        }
        return cell
    }
    
    
}
