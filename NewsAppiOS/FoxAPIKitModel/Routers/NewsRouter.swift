//
//  News Router.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 06/08/22.
//

import Foundation
import FoxAPIKit

public enum NewsRouter: BaseRouter {
    case fetchNews(_ params: [String:Any])
    public var method: HTTPMethod {
        switch self {
        case .fetchNews:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .fetchNews:
            return ""
        }
    }
    
    public var params: [String : Any] {
        switch self {
        case .fetchNews(let params):
            return params
        }
    }
    
    public var keypathToMap: String? {
        switch self {
        default:
            return "articles"
        }
    }
}
