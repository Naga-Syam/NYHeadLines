//
//  NetworkHandler.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import Foundation

class NetworkHandler {

    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, DataError>) -> Void
    ) {
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            guard let data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            completionHandler(.success(data))
        }
        session.resume()
    }

}
