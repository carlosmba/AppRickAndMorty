//
//  ItemHomeMenuViewModel.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/12/23.
//

import Foundation
struct ItemHomeMenuViewModel {
    private let menuItem : MenuItem
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    var title : String {
        menuItem.title.capitalized
    }
    
    var imageName : String {
        menuItem.title
    }
}
