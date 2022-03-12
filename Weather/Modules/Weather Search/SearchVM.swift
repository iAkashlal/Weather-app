//
//  SearchVM.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import Foundation

class SearchVM {
    var searchResultList: [String]? {
        didSet {
            self.reloadUI()
        }
    }
    
    var reloadUI: () -> Void = { }
    
    func performSearch(text: String) {
        print(text)
        // Make API call
        
        // Populate searchResultList variable
    }
    
}
