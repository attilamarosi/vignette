// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol NetworkService {
    func request<T: Codable>(apiVersion: APIVersion,
                             endpoint: Endpoint,
                             method: HTTPMethod,
                             query: String?,
                             body: String?) async throws -> T
}

// Default Implementation
extension NetworkService {
    func request<T: Codable>(apiVersion: APIVersion = .v1,
                             endpoint: Endpoint,
                             method: HTTPMethod = .get,
                             query: String? = nil,
                             body: String? = nil) async throws -> T {
        
        guard let endpointURL = URL(string: "\(apiVersion.rawValue)\(endpoint.urlSuffix)") else {
            throw APIError.badURL
        }
        
        guard var urlComponents = URLComponents(url: endpointURL,
                                                resolvingAgainstBaseURL: false) else {
            throw APIError.badURL
        }
        
        // Add query string if present
        if let query {
            urlComponents.query = query
        }

        guard let finalURL = urlComponents.url else {
            throw APIError.badURL
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set HTTP body if provided
        if let body {
            request.httpBody = body.data(using: .utf8)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.missingResponse
            }

            // Map known HTTP errors to APIError
            try APIError.throwIfError(from: httpResponse.statusCode)
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                throw APIError.decodingFailed
            }

        } catch let urlError as URLError {
            if urlError.code == .cancelled {
                throw APIError.cancelled
            } else {
                throw APIError.networkFailure
            }
        } catch {
            throw APIError.unknown
        }
    }
}
