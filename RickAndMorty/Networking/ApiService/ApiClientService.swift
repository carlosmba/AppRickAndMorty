//
//  ApiClientService.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
protocol ApiClientService{
    func request<T : Decodable>(url : URL?, type : T.Type) async throws -> T
}
