//
//  CharacterDTO+Mapping.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 12/03/24.
//

import Foundation
extension CharacterDTO {
    func toDomain() -> Character{
        let status = StatusCharacter(status: self.status)
        let specie = Specie(specie: self.species)
        let origin = Origin(name: self.origin.name, url: self.origin.url)
        let location = Location(name: self.location.name, type: self.location.type, dimension: self.location.dimension, url: self.location.url)
        let character = Character(id: self.id, name: self.name, status: status, specie: specie, urlCharacter: self.url, urlImage: self.image, origin: origin, location: location)
        return character
    }
}
