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
    var coordinator: RootCoordinator?
    
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
        
        let backgroundView = EmptyStateView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: searchTableView.frame.width,
                height: searchTableView.frame.height
            )
        )
        
        backgroundView.delegate = self
        searchTableView.backgroundView = backgroundView
        searchTableView.backgroundView?.isUserInteractionEnabled = true
        searchTableView.backgroundView?.isHidden = false
        backgroundView.configure(
            titleText: "Nothing to show",
            subtitleText: "Please enter a search term to fetch list of places",
            buttonText: "Go Random")
        viewModel.reloadUI = { [weak self] in
            self?.searchTableView.reloadData()
            let emptyResultsViewIsHidden = !((self?.viewModel.searchResultList?.count ?? 0) == 0)
            self?.searchTableView.backgroundView?.isHidden = emptyResultsViewIsHidden
            if !emptyResultsViewIsHidden {
                switch self?.searchBar.text?.isEmpty {
                case true:
                    backgroundView.configure(
                        titleText: "Nothing to show",
                        subtitleText: "Please enter a search term to fetch list of places",
                        buttonText: "Go Random")
                default:
                    backgroundView.configure(
                        titleText: "No results found",
                        subtitleText: "Please enter a different search term",
                        buttonText: "Go Random")
                }
            }
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
            coordinator?.presentDetailFor(location: location)
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

extension SearchVC: EmptyStateDelegate {
    func buttonDidTap(_ sender: UIButton) {
        print("Show all Tapped")
        self.searchBar.text = randomString()
        viewModel.performSearch(text: searchBar.text ?? "")
    }
    
    func randomString(length: Int = 1) -> String {
      let letters = "ABCDEFGHIJKLuNOPQRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
