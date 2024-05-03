//
//  CharacterDetailFactory.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 9/03/24.
//

import Foundation
import UIKit
import Combine
protocol CharacterDetailFactory {
    func makeModule(coordinator : CharacterDetailViewControllerCoordinator) -> UIViewController
}

struct CharacterDetailFactoryImpl : CharacterDetailFactory{
    private(set) var urlDetail : String
    private(set) var appContainer : AppConatiner
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClient = appContainer.apiClient
        let localClient = appContainer.localDataService
        let repository = CharacterDetailRepositoryImpl(remoteService: apiClient)
        let imageDataRepository = ImageDataRepositoryImpl(remoteDataService: apiClient, localDataCache: localClient)
        let imageDataUseCase = ImageDataUseCaseImpl(imageDataRepository: imageDataRepository)
        let loadCharacterUseCase = LoadCharacterDetailUseCaseImpl(characterDetailRepository: repository, urlDetail: urlDetail)
        let viewModel = CharacterDetailViewModelImpl(state: state, loadCharacterDetailUseCase: loadCharacterUseCase, dataImageUseCase: imageDataUseCase)
        let controller = CharacterDetailViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
    
    
}
