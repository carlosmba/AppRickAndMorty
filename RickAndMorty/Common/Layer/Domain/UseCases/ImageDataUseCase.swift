//
//  ImageDataUseCase.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/03/24.
//

import Foundation
protocol ImageDataUseCase {
    func getData(url : URL?) async -> Data?
    func getDataFromCache(url : URL?) -> Data?
}


struct ImageDataUseCaseImpl : ImageDataUseCase{
    private(set) var imageDataRepository : ImageDataRepository
    func getData(url: URL?) async -> Data? {
        await imageDataRepository.fetchData(url: url)
    }
    
    func getDataFromCache(url: URL?) -> Data? {
        imageDataRepository.getFromCache(url: url)
    }
    
    
}
