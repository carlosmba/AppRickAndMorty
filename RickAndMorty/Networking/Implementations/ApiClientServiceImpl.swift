//
//  ApiClientServiceImpl.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
struct ApiClientServiceImpl : ApiClientService {
    let session : URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    func request<T : Decodable>(url: URL?, type: T.Type) async throws -> T where T : Decodable {
        guard let url = url else { throw ApiError.errorInUrl }
        return try await makeRequest(url: url)
    }
    
    private func makeRequest<T : Decodable>(url : URL)async throws -> T{
        let request = try await session.data(from: url)
        return try validateRequest(requets: request)
    }
    
    private func validateRequest<T : Decodable>(requets : (data : Data, httpResponse : URLResponse))  throws -> T{
        guard let httpResponse = requets.httpResponse as? HTTPURLResponse else { throw ApiError.unknownError }
        
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return try decoModel(data: requets.data)
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    private func decoModel<T : Decodable>(data : Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
    
    
}
