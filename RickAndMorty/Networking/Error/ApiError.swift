//
//  ApiError.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 10/12/23.
//

import Foundation
enum ApiError : Error{
    case clientError
    case serverError
    case unknownError
    case errorInUrl
    case errorDecoding
}

extension ApiError : LocalizedError{
    public var errorDescription: String?{
        switch self {
            
        case .clientError:
            return NSLocalizedString("Client error", comment: "")
        case .serverError:
            return NSLocalizedString("Error Server", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown Error", comment: "")
        case .errorInUrl:
            return NSLocalizedString("Error URL", comment: "")
        case .errorDecoding:
            return NSLocalizedString("Error Decoding", comment: "")
        }
    }
}
