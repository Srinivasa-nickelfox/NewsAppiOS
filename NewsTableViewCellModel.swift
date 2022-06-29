//
//  NewsTableViewCellModel.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import Foundation

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
