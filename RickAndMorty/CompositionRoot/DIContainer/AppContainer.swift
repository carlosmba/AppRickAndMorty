//
//  AppContainer.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/03/24.
//

import Foundation
protocol AppConatiner {
    var apiClient : ApiClientService & RemoteImageDataService {get}
    var localDataService : LocalDataImageService {get}
    func getDataImageUseCase() -> ImageDataUseCase
}
struct AppContainerImpl : AppConatiner{
    var apiClient: ApiClientService & RemoteImageDataService = ApiClientServiceImpl()
    
    var localDataService: LocalDataImageService = LocalDataImageServiceImpl()
    
    func getDataImageUseCase() -> ImageDataUseCase {
        let imageDataRepository = ImageDataRepositoryImpl(remoteDataService: apiClient, localDataCache: localDataService)
        let imageDataUseCase = ImageDataUseCaseImpl(imageDataRepository: imageDataRepository)
        return imageDataUseCase
    }
    
    
}
