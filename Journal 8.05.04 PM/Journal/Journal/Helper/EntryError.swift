//
//  EntryError.swift
//  Journal
//
//  Created by Jaymond Richardson on 5/10/21.
//

import Foundation
enum EntryError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Could not unwrap. Not hype"
            
        }
    }
}
