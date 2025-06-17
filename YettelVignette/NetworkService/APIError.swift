// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

enum APIError: Int, CaseIterable, Error {
    
    // MARK: - General Errors (Custom codes < 0)
    case notDefined          = 0     // The error type is not defined
    case badURL              = -1    // The URL is not valid
    case missingResponse     = -2    // There's no server response received
    case decodingFailed      = -3    // Failed to decode the response from the server
    case networkFailure      = -4    // Network connectivity issues (e.g. offline)
    case cancelled           = -5    // Request was cancelled manually or by the system
    case unknown             = -999  // Unknown or unexpected error

    // MARK: - Client Errors (4xx)
    case badRequest          = 400   // 400 Malformed request syntax or invalid parameters
    case unauthorized        = 401   // 401 Authentication required or missing token
    case forbidden           = 403   // 403 Authenticated, but not allowed to access the resource
    case notFound            = 404   // 404 The requested resource does not exist
    case methodNotAllowed    = 405   // 405 HTTP method not allowed for the endpoint (e.g., using POST instead of GET)
    case timeout             = 408   // 408 The server timed out waiting for the request
    case tooManyRequests     = 429   // 429 The user has sent too many requests in a given time (rate-limiting)

    // MARK: - Server Errors (5xx)
    case internalServerError = 500   // 500 Internal Server Error
    case badGateway          = 502   // 502 Invalid response from an upstream server
    case serviceUnavailable  = 503   // 503 Server is temporarily unavailable, often due to maintenance or overload
    case gatewayTimeout      = 504   // 504 Server didn’t receive a timely response from the upstream server

    // MARK: - Static Helper

    /// Returns a matching `APIError` or `.notDefined` if the code is not mapped
    static func dropError(from errorCode: Int) -> APIError {
        APIError(rawValue: errorCode) ?? .notDefined
    }

    /// Throws a mapped `APIError` if the code is >= 400, otherwise does nothing
    static func throwIfError(from statusCode: Int) throws {
        if statusCode >= 400 {
            throw dropError(from: statusCode)
        }
    }

    // MARK: - Error Description
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL provided was invalid."
        case .missingResponse:
            return "No response received from the server."
        case .decodingFailed:
            return "Failed to decode the response from the server."
        case .networkFailure:
            return "Network request failed. Please check your internet connection."
        case .cancelled:
            return "The request was cancelled."
        case .badRequest:
            return "The request was invalid or malformed."
        case .unauthorized:
            return "You are not authorized to access this resource."
        case .forbidden:
            return "Access to this resource is forbidden."
        case .notFound:
            return "The requested resource could not be found."
        case .methodNotAllowed:
            return "The HTTP method used is not allowed for this endpoint."
        case .timeout:
            return "The request timed out."
        case .tooManyRequests:
            return "Too many requests. Please try again later."
        case .internalServerError:
            return "The server encountered an error."
        case .badGateway:
            return "Received an invalid response from an upstream server."
        case .serviceUnavailable:
            return "The server is currently unavailable. Please try again later."
        case .gatewayTimeout:
            return "The server took too long to respond."
        case .notDefined, .unknown:
            return "An unknown error occurred."
        }
    }
}
