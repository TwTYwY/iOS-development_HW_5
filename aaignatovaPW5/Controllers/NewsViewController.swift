//
//  ViewController.swift
//  aaignatovaPW5
//
//  Created by Anzhelika Ignatova on 10.02.2026.
//

import UIKit

class NewsViewController: UIViewController {
    // MARK: - Properties
    private let articleManager = ArticleManager()
    private let tableView = UITableView()
    private let cellIdentifier = "ArticleCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupArticleManager()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        title = "Новости"
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    private func setupArticleManager() {
        articleManager.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleManager.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleCell,
              let article = articleManager.getArticle(at: indexPath.row) else {
            return UITableViewCell()
        }
                
        cell.configure(with: article)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let article = articleManager.getArticle(at: indexPath.row) {
            print("Выбрана новость: \(article.title ?? "No title")")
            let articleUrl = article.articleUrl
            let webViewController = WebViewController()
            webViewController.url = articleUrl
            navigationController?.pushViewController(webViewController, animated: true)
        } else {
            print("Статья или URL не найдены")
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - ArticleManagerDelegate
extension NewsViewController: ArticleManagerDelegate {
    
    func articlesDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

