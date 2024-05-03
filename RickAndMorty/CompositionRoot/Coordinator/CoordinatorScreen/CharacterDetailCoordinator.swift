//
//  CharacterDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 9/03/24.
//

import Foundation
import UIKit
final class CharacterDetailCoordinator : Coordinator{
    var navigation: UINavigationController
    let characterDetailFactory : CharacterDetailFactory
    init(navigation: UINavigationController, characterDetailFactory: CharacterDetailFactory) {
        self.navigation = navigation
        self.characterDetailFactory = characterDetailFactory
    }
    
    func start() {
        let controller = characterDetailFactory.makeModule(coordinator: self)
        self.navigation.pushViewController(controller, animated: true)
    }
    
    
}

extension CharacterDetailCoordinator : CharacterDetailViewControllerCoordinator {
    func didTapOriginButton() {
        print("did tap Origin Button")
    }
    
    func didTapLocationButton() {
        print("did tap Location Button")
    }
    
    
}
