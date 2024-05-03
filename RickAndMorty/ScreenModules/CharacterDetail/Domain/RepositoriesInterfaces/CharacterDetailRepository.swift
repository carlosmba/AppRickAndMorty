//
//  CharacterDetailRepository.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 12/03/24.
//

import Foundation
protocol CharacterDetailRepository {
    func fetchCharacterDetail(urlDetail : String) async throws -> Character
}
