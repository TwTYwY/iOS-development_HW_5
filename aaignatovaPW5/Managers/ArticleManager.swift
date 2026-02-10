//
//  ArticleManager.swift
//  aaignatovaPW5
//
//  Created by Anzhelika Ignatova on 10.02.2026.
//

import Foundation

protocol ArticleManagerDelegate: AnyObject {
    func articlesDidUpdate()
}

class ArticleManager {
    // MARK: - Properties
    weak var delegate: ArticleManagerDelegate?
    private(set) var articles: [ArticleModel] = []
    
    // MARK: - Get URL
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    
    // MARK: - Parse URL
    private let decoder: JSONDecoder = JSONDecoder()
    private var newsPage: NewsPage = NewsPage()
    
    // MARK: - Fetch news
    private func fetchNews() {
        guard let url = getURL(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            if
                let self,
                let data = data,
                var newsPage = try? decoder.decode(NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                self.newsPage = newsPage
            }
        }.resume()
    }
    
    func getArticle(at index: Int) -> ArticleModel? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
}
