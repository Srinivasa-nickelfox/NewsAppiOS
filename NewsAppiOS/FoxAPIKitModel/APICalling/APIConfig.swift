//
//  APIConfig.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 06/08/22.
//

import Foundation

public struct APIConfig {
    
    public struct APIUrl {
        #if DEBUG
        static let domain = APIUrl.dev1
        #elseif DEV1
        static let domain = APIUrl.dev2
        #elseif DEV2
        static let domain = APIUrl.qa
        #elseif STAGING
        static let domain = APIUrl.staging
        #elseif RELEASE
        static let domain = APIUrl.prod
        #endif
        
        private static let dev1 = "https://newsapi.org/v2/everything"
        private static let dev2 = "https://newsapi.org/v2/top-headlines"
        private static let qa = "https://newsapi.org/v2/everything"
        private static let staging = "https://newsapi.org/v2/everything"
        private static let prod = "https://newsapi.org/v2/everything"
    }
}
