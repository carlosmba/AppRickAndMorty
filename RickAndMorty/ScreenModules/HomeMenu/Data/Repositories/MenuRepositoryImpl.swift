//
//  MenuRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/12/23.
//

import Foundation

struct MenuRepositoryImpl : MenuRepository{
    
    let apiClientService : ApiClientService
    let urlList : String
    func fetchMenuData() async throws -> [MenuItem] {
        let url = URL(string: urlList)
        return try await apiClientService.request(url: url, type: MenuDTO.self).toDomain()
        
    }
    
    
}
