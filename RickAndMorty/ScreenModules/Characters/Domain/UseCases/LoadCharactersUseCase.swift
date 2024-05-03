//
//  LoadCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 7/02/24.
//

import Foundation
protocol LoadCharacterUseCase {
    func execute() async -> Result<[Character], Error>
}

final class LoadCharacterUseCaseImpl : LoadCharacterUseCase{
    
    private let characterRepository : CharacterRepository
    
    private var url : String
    
    private var result : (info : Info, characters : [Character])?
    
    init(characterRepository: CharacterRepository, url: String) {
        self.characterRepository = characterRepository
        self.url = url
    }
    
    func execute() async -> Result<[Character], Error> {
        guard !url.isEmpty else { return .success([]) }
        do{
            let characters = try await characterRepository.fetchCharacters(urlList: url)
            url = characters.info.next ?? .empty
            return .success(characters.characters)
        }catch{
            return .failure(error)
        }
    }
    
    
}
