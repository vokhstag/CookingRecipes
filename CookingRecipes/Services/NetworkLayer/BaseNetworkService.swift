//
//  BaseNetworkService.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 22.11.2021.
//

import Foundation

open class BaseNetworkService {
    public typealias Handler = (Data?, URLResponse?, Error?) -> Void
    public lazy var session = URLSession(configuration: configuration)
    private let configuration = URLSessionConfiguration.default
    public let decoder = JSONDecoder()
    // MARK: - Constructor
    public init() {
    }
    public func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.nonResponse
        }

        switch httpResponse.statusCode {
        case 200:
            guard let data = data else { throw NetworkServiceError.unknown }
            return data
        case 400...499:
            throw NetworkServiceError.request(statusCode: httpResponse.statusCode)
        case 500...599:
            throw NetworkServiceError.network
        default:
            fatalError("Неизвестный статус код: \(httpResponse.statusCode)")
        }
    }
}
