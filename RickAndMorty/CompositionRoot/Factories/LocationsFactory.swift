//
//  LocationsFactory.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 31/03/24.
//

import Foundation
import UIKit
protocol LocationsFactory {
    func makeModule() -> UIViewController
}

struct LocationsFactoryImpl : LocationsFactory{
    let urlList : String
    let appContainer : AppConatiner
    
    func makeModule() -> UIViewController {
        let viewModel = LocationsViewM
        let module = LocationsViewController()
        module.title = AppLocalized.titleLocationsModule
        return module
    }
    
    
}
