//
//  LastPageValidationUseCase.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 13/02/24.
//

import Foundation
protocol LastPageValidationUseCase {
    var lastPage : Bool {get}
    mutating func updateLastPage(itemCount : Int)
    func checkAndLoadMoreItems(row : Int, currentItems : Int, action : () -> Void)
}
struct LastPageValidationUseCaseImpl : LastPageValidationUseCase{
    private var threshold = 5
    var lastPage: Bool = false
    
    mutating func updateLastPage(itemCount: Int) {
        if itemCount == Int.zero {
            lastPage = true
        }
    }
    
    func checkAndLoadMoreItems(
        row: Int,
        currentItems: Int,
        action: () -> Void) {
        guard !lastPage else {return}
        let limit = currentItems - threshold
        if limit == row {
            action()
        }
    }
    
    
}
