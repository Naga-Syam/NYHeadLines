//
//  ProductEndPoint.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import Foundation

enum NewsEndPoint {
    case news
}

extension NewsEndPoint: EndPointType {

    var path: String {
        switch self {
        case .news:
            return "articlesearch.json?q=election&api-key=j5GCulxBywG3lX211ZAPkAB8O381S5SM"
        }
    }

    var baseURL: String {
        switch self {
        case .news:
            return "https://api.nytimes.com/svc/search/v2/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .news:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .news:
            return nil
        }
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }
    
}
