//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 3/02/24.
//

import Foundation
protocol CharacterRepository {
    func fetchCharacters(urlList : String) async throws -> (info : Info, characters : [Character])
}
