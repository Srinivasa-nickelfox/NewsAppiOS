//
//  APIFetcher.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import Foundation

final class APIFetcher {
    static let shared = APIFetcher()
    
    struct Constants {
        static let topHeadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=e7855adfcfbb4dd69e3fd27172d1aa4e")
        static let searchUrlString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=af636d01048d448180b9daf62d844f43&q="
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article],Error>) -> Void) {
        guard let url = Constants.topHeadLinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
       }
       task.resume()
    }
}
