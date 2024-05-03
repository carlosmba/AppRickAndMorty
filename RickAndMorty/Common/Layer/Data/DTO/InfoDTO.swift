//
//  InfoDTO.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 3/02/24.
//

import Foundation
struct InfoDTO : Decodable {
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
}


