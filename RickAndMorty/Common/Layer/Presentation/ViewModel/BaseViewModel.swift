//
//  BaseViewModel.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 7/02/24.
//

import Combine
protocol BaseViewModel {
    var state : PassthroughSubject<StateController, Never> {get}
    func viewDidLoad()
}
