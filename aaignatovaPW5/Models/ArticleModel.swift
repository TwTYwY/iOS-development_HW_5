//
//  ArticleModel.swift
//  aaignatovaPW5
//
//  Created by Anzhelika Ignatova on 10.02.2026.
//

import Foundation

struct ArticleModel {
    let id: UUID
    let title: String
    let description: String
    let publishedAt: Date
    let source: String
    let url: URL?
    let imageUrl: URL?
    
    init(title: String, description: String, source: String, url: URL? = nil, imageUrl: URL? = nil) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.publishedAt = Date()
        self.source = source
        self.url = url
        self.imageUrl = imageUrl
    }
}
