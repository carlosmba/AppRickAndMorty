//
//  PropertyIterator.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
protocol PropertyIterator{
    
}

extension PropertyIterator {
    func dictionaryProperties() -> [String : Any]{
        let mirror = Mirror(reflecting: self)
        var dictionary : [String : Any] = [:]
        
        mirror.children.forEach{ property in
            dictionary[property.label ?? String()] = property.value
        }
        return dictionary
    }
}
