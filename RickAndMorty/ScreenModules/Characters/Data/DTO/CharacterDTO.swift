//
//  CharacterDTO.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 21/01/24.
//

import Foundation
struct CharacterDTO : Decodable{
    let id: Int
    let name : String
    let status : String?
    let species : String?
    let image : String?
    let url : String
    let origin : OriginDTO
    let location : LocationDTO
    
}
