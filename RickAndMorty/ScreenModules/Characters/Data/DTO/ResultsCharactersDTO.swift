//
//  ResultsCharactersDTO.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 21/01/24.
//

import Foundation
struct ResultsCharactersDTO : Decodable{
    let results : [CharacterDTO]
    let info : InfoDTO
}
