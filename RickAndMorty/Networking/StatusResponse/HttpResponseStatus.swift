//
//  HttpResponseStatus.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
enum HttpResponseStatus {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
}
