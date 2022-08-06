//
//  Base Router.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 06/08/22.
//

import Foundation
import FoxAPIKit

public protocol BaseRouter: Router {
    
}

public let defaultPerPage = 10

extension BaseRouter {
    public var method: HTTPMethod {
        return .get
    }
    
    public var path: String {
        return ""
    }
    
    public var params: [String : Any] {
        return [:]
    }
    
    public var baseUrl: URL {
        return URL(string: APIConfig.APIUrl.domain)!
    }
    
    public var headers: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    public var encoding: URLEncoding? {
        return nil
    }
    
    public var timeoutInterval: TimeInterval? {
        return nil
    }
    
    public var keypathToMap: String? {
        return nil
    }
}
