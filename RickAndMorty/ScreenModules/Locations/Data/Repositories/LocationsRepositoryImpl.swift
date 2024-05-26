//
//  LocationsRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 1/05/24.
//

import Foundation
struct LocationsRepositoryImpl : LocationsRepository{
    
    let apiService : ApiClientService
    
    func fetchLocations(urlList: String) async throws -> (info: Info, locations: [Location]) {
        apiService.request(url: URL(string: urlList), type: ResultsLocationsDTO.self)
    }
    
    
}
