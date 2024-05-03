//
//  LocationsViewModel.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 31/03/24.
//

import Foundation
import Combine
protocol LocationsViewModel : BaseViewModel {
    var locationsCount : Int {get}
    var lastPage : Bool {get}
}

final class LocationsViewModelImpl : LocationsViewModel {
    var locationsCount : Int = 0
    
    var lastPage: Bool = false
    
    var state: PassthroughSubject<StateController, Never>
    
    let fetchLocationsUseCase : Location
    
    init(state: PassthroughSubject<StateController, Never>) {
        self.state = state
    }
    
    func viewDidLoad() {
        
    }
    
    
    
  
    
    
    
    
}
