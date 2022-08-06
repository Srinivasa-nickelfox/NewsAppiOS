//
//  ErrorResponse.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 06/08/22.
//

import Foundation
import FoxAPIKit
import JSONParsing

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
    public var message: String {
        return self.messages.joined(separator: ", ")
    }
    
    public var domain: String {
        return ""
    }
    // change structure according to API
    public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
        if 200...299 ~= code {
            return try ErrorResponse(
                code: json["statusCode"]^,
                messages: json["error"]["message"]^^
            )
            }
        return try ErrorResponse(
            code: json["code"]^,
            messages: json["error"]["message"]^^
        )
    }
    
    public var code: Int
    public var messages: [String]
    
    public var title: String {
        return "Error"
    }
}
