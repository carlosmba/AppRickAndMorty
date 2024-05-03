//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/03/24.
//

import Foundation
import Combine
protocol CharacterDetailViewModel : BaseViewModel{
    var nameCharacter : String {get}
    var status : String {get}
    var specie : String {get}
    var imageData : Data? {get}
    var origin : String {get}
    var location : String {get}
}

final class CharacterDetailViewModelImpl : CharacterDetailViewModel{
    var nameCharacter: String {
        character?.name ?? .empty
    }
    
    var status: String{
        character?.status?.description ?? .empty
    }
    
    var specie: String{
        character?.specie.description ?? .empty
    }
    
    var imageData: Data?{
        dataImageUseCase.getDataFromCache(url: URL(string: character?.urlImage ?? .empty))
    }
    
    var origin: String{
        character?.origin.name ?? .empty
    }
    
    var location: String{
        character?.location.name ?? .empty
    }
    
    var state: PassthroughSubject<StateController, Never>
    private let loadCharacterDetailUseCase : LoadCharacterDetailUseCase
    private let dataImageUseCase : ImageDataUseCase
    private var character : Character?
    
    init(state: PassthroughSubject<StateController, Never>, loadCharacterDetailUseCase: LoadCharacterDetailUseCase, dataImageUseCase: ImageDataUseCase) {
        self.state = state
        self.loadCharacterDetailUseCase = loadCharacterDetailUseCase
        self.dataImageUseCase = dataImageUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task{
            do {
                let characterResult = try await loadCharacterDetailUseCase.execute()
                self.character = characterResult
                state.send(.success)
            }catch{
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    
    
}
