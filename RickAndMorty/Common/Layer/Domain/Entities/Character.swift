//
//  Character.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 18/01/24.
//

import Foundation
struct Character {
    let id: Int
    let name : String
    let status : StatusCharacter?
    let specie : Specie
    let urlCharacter : String
    let urlImage : String?
    let origin : Origin
    let location : Location
}
