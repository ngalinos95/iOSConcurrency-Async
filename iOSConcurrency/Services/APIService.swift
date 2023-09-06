//
//  APIService.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 5/9/23.
//

import Foundation

struct APIService {
    let urlString: String

    func getAPI<T: Decodable>() async throws -> T {
        guard let url = URL(string: urlString)
        else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                return decodeData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
}

// We create our own enum for costum LocalizedError handling
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL error", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The API failed to issue a valid response", comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("The data provided appears to be corrupt", comment: "")
        case .decodingError(let string):
            return string
        }
    }

}
