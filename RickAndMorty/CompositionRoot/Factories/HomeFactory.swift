//
//  HomeFactory.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 24/11/23.
//


import UIKit
import Combine
protocol HomeFactory {
    func makeModule(coordinator : HomeMenuControllerCoordinator) -> UIViewController
    func makeCoordinatorCharacter(navigation : UINavigationController, urlList : String) -> Coordinator
    func makeCoordinatorLocations(navigation : UINavigationController, urlList : String) -> Coordinator
}

struct HomeFactoryImpl : HomeFactory{
    
    let appContainer : AppConatiner
    func makeModule(coordinator : HomeMenuControllerCoordinator) -> UIViewController {
        let apiClientService = ApiClientServiceImpl()
        let menuRepository = MenuRepositoryImpl(apiClientService: apiClientService, urlList: Endpoint.baseUrl)
        let loadUseCase = LoadMenuUseCaseImpl(menuRepository: menuRepository)
        let state = PassthroughSubject<StateController, Never>()
        let homeViewModel = HomeMenuViewModelImpl(state: state, loadMenuUseCase: loadUseCase)
        let homeController = HomeMenuController(viewModel: homeViewModel,layout: makeLayout(), coordinator: coordinator)
        homeController.title = AppLocalized.appName
        return homeController
    }
    
    private func makeLayout()-> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (ViewValues.widthScreen - ViewValues.doublePadding) / ViewValues.multiplierTwo
        let layoutHeight = (UIScreen.main.bounds.width - ViewValues.doublePadding) / ViewValues.multiplierTwo
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: ViewValues.normalPadding, bottom: .zero, right: ViewValues.normalPadding)
        return layout
    }
    
    func makeCoordinatorCharacter(navigation: UINavigationController, urlList: String) -> Coordinator {
        let characterFactory = CharacterFactoryImpl(urlList: urlList, appContainer: appContainer)
        let characterCoordinator = CharacterCoordinator(navigation: navigation, characterFactory: characterFactory)
        return characterCoordinator
    }
    
    func makeCoordinatorLocations(navigation: UINavigationController, urlList: String) -> Coordinator {
        let locationFactory = LocationsFactoryImpl(urlList: urlList, appContainer: appContainer)
        let coordinator = LocationsCoordinator(navigation: navigation, locationsFactory: locationFactory)
        return coordinator
    }
    
    
}
