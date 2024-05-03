//
//  RemoteImageDataService.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/03/24.
//

import Foundation
protocol RemoteImageDataService {
    func request(url : URL?) async -> Data?
}
