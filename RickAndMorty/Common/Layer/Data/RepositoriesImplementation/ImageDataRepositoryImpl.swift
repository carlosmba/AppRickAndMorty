//
//  ImageDataRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/03/24.
//

import Foundation
struct ImageDataRepositoryImpl : ImageDataRepository{
    
    private(set) var remoteDataService : RemoteImageDataService
    private(set) var localDataCache : LocalDataImageService
    func fetchData(url: URL?) async -> Data? {
        let data = await remoteDataService.request(url: url)
        localDataCache.save(key: url?.absoluteString ?? .empty, data: data)
        return data
    }
    
    func getFromCache(url: URL?) -> Data? {
        localDataCache.get(key: url?.absoluteString ?? .empty)
    }
    
    
}
