//
//  MenuDTO+Mapper.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
extension MenuDTO {
    func toDomain() -> [MenuItem]{
        return self.dictionaryProperties().map{ dictionary in
            let title = dictionary.key
            let url = (dictionary.value as? String) ?? String()
            return MenuItem(title: title, url: url)
        }
    }
}
