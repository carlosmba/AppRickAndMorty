//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 23/11/23.
//
import UIKit

protocol Coordinator {
    var navigation : UINavigationController {get}
    func start()
}
