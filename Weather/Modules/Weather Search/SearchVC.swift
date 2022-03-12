//
//  SearchVC.swift
//  Weather
//
//  Created by akashlal on 12/03/22.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = SearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.performSearch(text: searchText)
    }
    
}
