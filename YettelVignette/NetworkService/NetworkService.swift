// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol NetworkService {
    func request<T: Codable, U: NetworkModel>(apiVersion: APIVersion,
                                              endpoint: Endpoint,
                                              method: HTTPMethod,
                                              query: String?,
                                              body: U?,
                                              rawBody: String?) async throws -> T
    
    func request<T: Codable>(apiVersion: APIVersion,
                             endpoint: Endpoint,
                             method: HTTPMethod,
                             query: String?,
                             rawBody: String?) async throws -> T
}

// Default Implementation
extension NetworkService {
    func request<T: Codable, U: NetworkModel>(apiVersion: APIVersion = .v1,
                                              endpoint: Endpoint,
                                              method: HTTPMethod = .get,
                                              query: String? = nil,
                                              body: U? = nil,
                                              rawBody: String? = nil) async throws -> T {
        
        // TODO: Move url into scheme
        let urlPrefix = "http://127.0.0.1:8080/"

        guard let endpointURL = URL(string: "\(urlPrefix)\(apiVersion.rawValue)\(endpoint.urlSuffix)") else {
            throw APIError.badURL
        }

        guard var urlComponents = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false) else {
            throw APIError.badURL
        }

        if let query {
            urlComponents.query = query
        }

        guard let finalURL = urlComponents.url else {
            throw APIError.badURL
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        } else if let rawBody {
            request.httpBody = rawBody.data(using: .utf8)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.missingResponse
            }

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

    func request<T: Codable>(apiVersion: APIVersion = .v1,
                             endpoint: Endpoint,
                             method: HTTPMethod = .get,
                             query: String? = nil,
                             rawBody: String? = nil) async throws -> T {
        return try await request(apiVersion: apiVersion,
                                 endpoint: endpoint,
                                 method: method,
                                 query: query,
                                 body: Optional<EmptyRequestBody>.none,
                                 rawBody: rawBody)
    }
}
