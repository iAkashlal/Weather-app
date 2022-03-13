//
//  SearchVM.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import Foundation

class SearchVM {
    var searchResultList: [SearchResultModel]?
    
    var reloadUI: () -> Void = { }
    var isLoading: Bool = false {
        didSet {
            self.reloadUI()
        }
    }
    
    func performSearch(text: String) {
        isLoading = true
        // Make API call
        WeatherAPI.provider.request(.seachText(text: text)) {
            [weak self] result in
            switch result{
            case .success(let response):
                let decoder = JSONDecoder()
                // Populating searchResultList variable
                self?.searchResultList = try? decoder.decode(
                    [SearchResultModel].self,
                    from: response.data
                )
                self?.isLoading = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
