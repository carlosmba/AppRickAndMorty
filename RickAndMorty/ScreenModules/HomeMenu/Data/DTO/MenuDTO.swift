//
//  MenuDTO.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
struct MenuDTO : Decodable {
    let characters : String
    let locations : String
    let episodes : String
}

extension MenuDTO :  PropertyIterator{}
