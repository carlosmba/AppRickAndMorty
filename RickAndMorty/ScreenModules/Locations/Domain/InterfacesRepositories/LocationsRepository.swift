//
//  LocationsRepository.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 20/04/24.
//

import Foundation
protocol LocationsRepository {
    func fetchLocations(urlList : String) async throws -> (info : Info, locations : [Location])
}
