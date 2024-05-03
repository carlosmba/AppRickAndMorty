//
//  ApiClientService+RemoteImageDataService.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 4/03/24.
//

import Foundation
extension ApiClientServiceImpl : RemoteImageDataService {
    func request(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        
        do{
            let (data : Data, request : Request) = try await session.data(from: url)
            return (data : Data, request : Request).data
        }catch {
            return nil
        }
    }
    
    
}
