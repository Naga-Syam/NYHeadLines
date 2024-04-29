//
//  APIManager.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

final class APIManager {

    static let shared = APIManager()
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler

    init(networkHandler: NetworkHandler = NetworkHandler(),
         responseHandler: ResponseHandler = ResponseHandler()) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }

    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping ResultHandler<T>
    ) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = type.headers
        networkHandler.requestDataAPI(url: request) { result in
            switch result {
            case .success(let data):
                self.responseHandler.parseResonseDecode(
                    data: data,
                    modelType: modelType) { response in
                        switch response {
                        case .success(let mainResponse):
                            completion(.success(mainResponse))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }

}




