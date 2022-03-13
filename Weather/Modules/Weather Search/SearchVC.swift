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
        if let location = viewModel.searchResultList?[indexPath.row] {
            print("location with lat\(location.lat) and long \(location.lon) tapped" )
        }
        searchTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchListTVC = searchTableView.dequeueReusableCell(forIndexPath: indexPath)
        if let location = viewModel.searchResultList?[indexPath.row] {
            cell.configure(for: location)
        }
        return cell
    }
    
    
}
