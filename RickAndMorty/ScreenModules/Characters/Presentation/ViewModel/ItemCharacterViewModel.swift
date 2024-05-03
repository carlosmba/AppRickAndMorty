//
//  ItemCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 7/02/24.
//

import Foundation
struct ItemCharacterViewModel {
    private(set) var character : Character
    private(set) var imageDataUseCase : ImageDataUseCase
    
    
    var name : String {
        character.name
    }
    
    var specie : String {
        character.specie.description
    }
    
    var status : String {
        character.status?.description ?? ""
    }
    
    var imageData : Data? {
        imageDataUseCase.getDataFromCache(url: URL(string: character.urlImage ?? .empty))
    }
    
    func getImageDataRemote() async -> Data?{
        if let url = character.urlImage{
            if let data = await imageDataUseCase.getData(url: URL(string: url)){
                return data
            }
        }
        return nil
    }
    
    
    
}
