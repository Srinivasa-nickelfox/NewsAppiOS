//
//  NewsAPIClient.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 06/08/22.
//

import Foundation
import FoxAPIKit

public typealias APICompletion<T> = (APIResult<T>) -> Void

class NewsAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    
    static let shared = NewsAPIClient()
    
    override init() {
        super.init()
        #if DEBUG
        enableLogs = true
        #else
        enableLogs = false
        #endif
    }
    
    override func authenticationHeaders(response: HTTPURLResponse) -> AuthHeaders? {
        return nil
    }
}

