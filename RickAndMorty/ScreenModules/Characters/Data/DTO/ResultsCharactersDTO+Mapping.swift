//
//  ResultsCharactersDTO+Mapping.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/02/24.
//

import Foundation
extension ResultsCharactersDTO{
    func toDomain() -> (info: Info, characters: [Character]){
        let characters = results.map{
            let status = StatusCharacter(status: $0.status)
            let specie = Specie(specie: $0.species)
            let origin = Origin(name: $0.origin.name, url: $0.origin.url)
            let location = Location(name: $0.location.name, type: $0.location.type, dimension: $0.location.dimension, url: $0.location.url)
            return Character(id: $0.id, name: $0.name, status: status, specie: specie, urlCharacter: $0.url, urlImage: $0.image, origin: origin, location: location)
        }
        
        let info = Info(next: info.next)
        return (info : info, characters : characters)
    }
}
