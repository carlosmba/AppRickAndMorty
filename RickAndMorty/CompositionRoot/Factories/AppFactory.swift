//
//  AppFactory.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 23/11/23.
//

import Foundation
import UIKit
protocol AppFactory {
    func makeHomeCoordinator(navigation : UINavigationController) -> Coordinator
}

struct AppFactoryImpl : AppFactory {
    let appContainer : AppConatiner
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let homeFactory = HomeFactoryImpl(appContainer: appContainer)
        let homeCoordinator = HomeCoordinator(navigation: navigation, homeFactory: homeFactory)
        return homeCoordinator
    }
    
    
    
    
}

