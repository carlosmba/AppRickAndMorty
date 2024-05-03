//
//  CharacterCoordinator.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 22/12/23.
//

import Foundation
import UIKit
final class CharacterCoordinator : Coordinator{
    var navigation: UINavigationController
    var characterFactory : CharactersFactory
    
    init(navigation: UINavigationController, characterFactory: CharactersFactory) {
        self.navigation = navigation
        self.characterFactory = characterFactory
    }
    func start() {
        let controller = characterFactory.makeModule(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
    
    
}


extension CharacterCoordinator : CharacterViewControllerCoordinator{
    func didSelectMenuCell(urlDetail: String) {
        let coordinator = self.characterFactory.makeCharacterDetailCoordinator(navigation: self.navigation, urlDetail: urlDetail)
        coordinator.start()
    }
    
    
}
