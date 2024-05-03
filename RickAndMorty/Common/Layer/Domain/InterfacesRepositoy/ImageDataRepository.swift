//
//  ImageDataRepository.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/03/24.
//

import Foundation
protocol ImageDataRepository {
    func fetchData(url : URL?) async -> Data?
    func getFromCache(url : URL?) -> Data?
}
