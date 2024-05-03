//
//  Reusable.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 29/11/23.
//
protocol Reusable {
    
}

extension Reusable {
    static var reuseIdentifier : String {String(describing: self)}
}
