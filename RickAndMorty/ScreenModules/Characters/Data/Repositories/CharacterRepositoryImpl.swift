//
//  CharacterRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 3/02/24.
//

import Foundation
struct CharacterRepositoryImpl : CharacterRepository {
    
    let apiClient : ApiClientService
    
    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character]) {
        let url = URL(string: urlList)
        return try await apiClient.request(url: url, type: ResultsCharactersDTO.self).toDomain()
    }
    
    
}
