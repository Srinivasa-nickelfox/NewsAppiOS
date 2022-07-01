//
//  NewsTableViewCellModel.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 30/06/22.
//

import Foundation

// Model for API Data to parse into TableView

class NewsTableViewCellModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
