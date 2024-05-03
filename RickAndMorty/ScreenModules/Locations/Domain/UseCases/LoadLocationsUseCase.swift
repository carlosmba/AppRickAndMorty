//
//  FetchLocationsUseCase.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 1/05/24.
//

import Foundation
protocol LoadLocationsUseCase {
    func execute() async -> Result<[Location], Error>
}

final class LoadLocationsUseCaseImpl : LoadLocationsUseCase{
    
    var url : String
    final let locationRepository : LocationsRepository
    
    init(url: String, locationRepository: LocationsRepository) {
        self.url = url
        self.locationRepository = locationRepository
    }
    
    func execute() async -> Result<[Location], Error>{
        guard !url.isEmpty else {return .success([])}
        do{
            let result = try await locationRepository.fetchLocations(urlList: url)
            url = result.info.next ?? .empty
            return .success(result.locations)
        }catch {
            return .failure(error)
        }
    }
    
    
    
}

