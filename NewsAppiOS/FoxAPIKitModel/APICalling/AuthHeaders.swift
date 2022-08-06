//
//  AuthHeaders.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 06/08/22.
//

import Foundation
import FoxAPIKit
import JSONParsing
import SwiftyJSON

public struct AuthHeaders: AuthHeadersProtocol {
    
    let authorizationToken: String?
    
    public static func parse(_ json: JSON) throws -> AuthHeaders {
        return try AuthHeaders(authorizationToken: json[authorizationTokenKey]^
        )
    }
    
    public func toJSON() -> [String : String] {
        let res: [String: String] = [
        authorizationTokenKey: self.authorizationToken ?? ""
        ]
        return res
    }
    
    public var isValid: Bool {
        return !(self.authorizationToken?.isEmpty ?? true)
    }
    
    public func headerWithAuthToken() -> [String: String] {
        var header: [String:String] = [contentType: "application/json"]
        if let token = self.authorizationToken {
            header.updateValue("Bearer \(token)", forKey: authorizationTokenKey)
        }
        return header
    }
}

extension AuthHeaders {
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let token = self.authorizationToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: authorizationTokenKey)
        }
        return urlRequest
    }
}

private let authorizationTokenKey = "Authorization"
private let contentType = "Content-Type"
