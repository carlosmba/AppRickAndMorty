//
//  CharactersFactory.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 20/12/23.
//

import Foundation
import UIKit
import Combine
protocol CharactersFactory {
    func makeModule(coordinator : CharacterViewControllerCoordinator) -> UIViewController
    func makeCharacterDetailCoordinator (navigation : UINavigationController,urlDetail : String) -> Coordinator
}

struct CharacterFactoryImpl : CharactersFactory{
    func makeCharacterDetailCoordinator(navigation : UINavigationController, urlDetail : String) -> Coordinator {
        let factory = CharacterDetailFactoryImpl(urlDetail: urlDetail, appContainer: self.appContainer)
        let coordinator = CharacterDetailCoordinator(navigation: navigation, characterDetailFactory: factory)
        
        return coordinator
    }
    
    let urlList : String
    let appContainer : AppConatiner
    func makeModule(coordinator: CharacterViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClient = appContainer.apiClient
        let charactersRepository = CharacterRepositoryImpl(apiClient: apiClient)
        let lastPageValidationUseCase = LastPageValidationUseCaseImpl()
        let loadCharactersUseCase = LoadCharacterUseCaseImpl(characterRepository: charactersRepository, url: urlList)
        let viewModel = CharactersViewModelImpl(
            state: state,
            loadCharacterUseCase: loadCharactersUseCase,
            lastPageValidationUseCase: lastPageValidationUseCase,
            imageDataUseCase: appContainer.getDataImageUseCase()
        )
        let controller = CharacterViewController(viewModel: viewModel, coordinator: coordinator)
        controller.title = AppLocalized.titleCharacterModule
        return controller
    }
    
    
}
