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
    
    // MARK: - Initializer
    init() {
        fetchNews()
    }
    
    // MARK: - Fetch news
    private func fetchNews() {
        guard let url = getURL(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let self = self else { return }
            
            if let data = data {
                do {
                    var newsPage = try self.decoder.decode(NewsPage.self, from: data)
                    newsPage.passTheRequestId()
                    self.newsPage = newsPage
                    
                    self.articles = newsPage.news ?? []
                    
                    print("Successfully loaded \(self.articles.count) articles")
                    
                    DispatchQueue.main.async {
                        self.delegate?.articlesDidUpdate()
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: - Public Methods
    func getArticle(at index: Int) -> ArticleModel? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
    
    func refreshNews() {
        fetchNews()
    }
}
