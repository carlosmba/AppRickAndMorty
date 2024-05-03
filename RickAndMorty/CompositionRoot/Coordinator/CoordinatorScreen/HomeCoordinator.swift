//
//  HomeCoordinator.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 24/11/23.
//

import UIKit
final class HomeCoordinator : Coordinator{
    var navigation: UINavigationController
    private let homeFactory : HomeFactory
    
    init(navigation: UINavigationController, homeFactory : HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }
    
    func start() {
        let controller = homeFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
    
    
}


extension HomeCoordinator : HomeMenuControllerCoordinator{
    func didSelectMenuCell(model: MenuItem) {
        switch HomeSelectScreen(rawValue: model.title){
        case .locations:
            goToLocations(urlList : model.url)
        case .characters:
            goToCharacters(urlList: model.url)
        case .episodes:
            goToEpisodes()
        case .none:
            break
        }
        
    }
    
    
    private func goToCharacters(urlList : String){
        let characterCoordinator = homeFactory.makeCoordinatorCharacter(navigation: navigation, urlList: urlList)
        characterCoordinator.start()
    }
    
    private func goToLocations(urlList : String){
        let coordinator = homeFactory.makeCoordinatorLocations(navigation: self.navigation, urlList: urlList)
        coordinator.start()
    }
    
    private func goToEpisodes(){
        print("Go To Episodes")
    }
    
    
}
