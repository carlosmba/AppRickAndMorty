//
//  CharacterDetailRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 12/03/24.
//

import Foundation
struct CharacterDetailRepositoryImpl : CharacterDetailRepository{
    private(set) var remoteService : ApiClientService
    func fetchCharacterDetail(urlDetail: String) async throws -> Character {
        let url = URL(string: urlDetail)
        let result = try await remoteService.request(url: url, type: CharacterDTO.self)
        return result.toDomain()
    }
    
    
    
    
}
