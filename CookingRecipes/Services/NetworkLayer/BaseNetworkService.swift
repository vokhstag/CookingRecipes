//
//  BaseNetworkService.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 15.11.2021.
//

import Foundation

class BaseNetworkService {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    lazy var session = URLSession(configuration: configuration)
    private let configuration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
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
