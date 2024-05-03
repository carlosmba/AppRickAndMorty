//
//  LocationsCoordinator.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 31/03/24.
//

import Foundation
import UIKit
final class LocationsCoordinator : Coordinator {
    var navigation: UINavigationController
    let locationsFactory : LocationsFactory
    
    init(navigation: UINavigationController, locationsFactory: LocationsFactory) {
        self.navigation = navigation
        self.locationsFactory = locationsFactory
    }
    
    func start() {
        let controller = locationsFactory.makeModule()
        self.navigation.pushViewController(controller, animated: true)
    }
    
    
}
