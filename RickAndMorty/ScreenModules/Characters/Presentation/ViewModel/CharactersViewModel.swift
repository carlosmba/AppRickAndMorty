//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 7/02/24.
//

import Foundation
import Combine
protocol CharactersViewModel : BaseViewModel{
    var itemCharactersCount : Int {get}
    var lastPage : Bool {get}
    func getItemMenuViewModel(row : Int) -> ItemCharacterViewModel
    func getUrlDetail(row : Int) -> String
}

final class CharactersViewModelImpl : CharactersViewModel{
    
    var lastPage : Bool {
        self.lastPageValidationUseCase.lastPage
    }
    var state: PassthroughSubject<StateController, Never>
    var itemCharactersCount: Int {
        characters.count
    }
    private var characters : [Character] = []
    private let loadCharacterUseCase : LoadCharacterUseCase
    private var lastPageValidationUseCase : LastPageValidationUseCase
    private var imageDataUseCase : ImageDataUseCase
    
    init(state: PassthroughSubject<StateController, Never>,
         loadCharacterUseCase: LoadCharacterUseCase,
         lastPageValidationUseCase : LastPageValidationUseCase,
         imageDataUseCase : ImageDataUseCase
    
    )
    {
        self.state = state
        self.loadCharacterUseCase = loadCharacterUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    
    func viewDidLoad() {
        self.state.send(.loading)
        Task { [weak self] in
            await self?.loadCharactersUseCase()
            
        }
    }
    
    private func loadCharactersUseCase() async{
        let resultUseCase = await loadCharacterUseCase.execute()
        updateStateUI( result: resultUseCase)
    }
    
    private func updateStateUI(result : Result<[Character], Error>){
        
        switch result {
        case .success(let characters):
            self.characters.append(contentsOf: characters)
            self.lastPageValidationUseCase.updateLastPage(itemCount: characters.count)
            self.state.send(.success)
        case .failure(let error):
            self.state.send(.fail(error: error.localizedDescription))
        }
        
    }
    
    func getItemMenuViewModel(row: Int) -> ItemCharacterViewModel {
        let character = characters[row]
        checkLastPageAndLoadCharacters(row: row)
        return ItemCharacterViewModel(character: character, imageDataUseCase: imageDataUseCase)
    }
    
    private func checkLastPageAndLoadCharacters(row : Int){
        self.lastPageValidationUseCase.checkAndLoadMoreItems(row: row, currentItems: self.characters.count, action: viewDidLoad)
    }
    
    func getUrlDetail(row: Int) -> String {
        let character = characters[row]
        return character.urlCharacter
    }
    
    
}
