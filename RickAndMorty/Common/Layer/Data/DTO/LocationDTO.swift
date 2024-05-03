//
//  LocationDTO.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 3/02/24.
//

import Foundation
struct LocationDTO : Decodable {
    let name : String
    let type : String?
    let dimension : String?
    let url : String
    
}
