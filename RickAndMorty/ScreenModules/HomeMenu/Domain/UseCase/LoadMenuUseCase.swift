//
//  LoadMenuUseCase.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/12/23.
//

protocol LoadMenuUseCase {
    func execute() async -> Result<[MenuItem], Error>
}

struct LoadMenuUseCaseImpl : LoadMenuUseCase{
    
    let menuRepository : MenuRepository
    func execute() async -> Result<[MenuItem], Error> {
        do {
            let repositoryResult = try await menuRepository.fetchMenuData()
            return .success(repositoryResult)
        }catch{
            return .failure(error)
        }
        
    }
    
    
}
