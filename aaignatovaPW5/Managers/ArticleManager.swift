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
    private(set) var articles: [ArticleModel] = [] {
        didSet {
            delegate?.articlesDidUpdate()
        }
    }
    
    weak var delegate: ArticleManagerDelegate?
    
    // MARK: - Initialization
    init() {
        loadSampleArticles()
    }
    
    // MARK: - Public Methods
    func addArticle(_ article: ArticleModel) {
        articles.insert(article, at: 0)
    }
    
    func removeArticle(at index: Int) {
        guard index >= 0 && index < articles.count else { return }
        articles.remove(at: index)
    }
    
    func getArticle(at index: Int) -> ArticleModel? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
    
    func clearArticles() {
        articles.removeAll()
    }
    
    // MARK: - Private Methods
    private func loadSampleArticles() {
        // Временные данные для тестирования
        let sampleArticles = [
            ArticleModel(
                title: "Apple представила новый iPhone",
                description: "Компания Apple провела презентацию новых моделей iPhone",
                source: "TechCrunch"
            ),
            ArticleModel(
                title: "Новые функции в iOS 18",
                description: "Анонсированы ключевые обновления операционной системы",
                source: "The Verge"
            ),
            ArticleModel(
                title: "Рынок акций вырос",
                description: "Основные индексы показали рост на фоне позитивных новостей",
                source: "Bloomberg"
            ),
            ArticleModel(
                title: "Изменения в налоговом законодательстве",
                description: "Правительство внесло поправки в налоговый кодекс",
                source: "Financial Times"
            ),
            ArticleModel(
                title: "Прорыв в исследованиях ИИ",
                description: "Ученые создали новую архитектуру нейросетей",
                source: "MIT News"
            )
        ]
        
        articles = sampleArticles
    }
}
