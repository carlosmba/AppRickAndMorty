//
//  LoadCharacterDetailUseCase.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 12/03/24.
//

import Foundation
protocol LoadCharacterDetailUseCase {
    func execute() async throws -> Character
}

struct LoadCharacterDetailUseCaseImpl  : LoadCharacterDetailUseCase{
    
    private(set) var characterDetailRepository : CharacterDetailRepository
    private(set) var urlDetail : String
    func execute() async throws -> Character {
        try await characterDetailRepository.fetchCharacterDetail(urlDetail: urlDetail)
    }
    
    
}
