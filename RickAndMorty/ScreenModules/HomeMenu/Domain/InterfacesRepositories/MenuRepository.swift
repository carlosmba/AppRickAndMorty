//
//  MenuRepository.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/12/23.
//

protocol MenuRepository {
    func fetchMenuData()async throws -> [MenuItem]
}
