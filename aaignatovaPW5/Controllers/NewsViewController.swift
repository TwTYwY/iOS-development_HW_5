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
    private let cellIdentifier = "NewsCell"
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let article = articleManager.getArticle(at: indexPath.row) {
            cell.textLabel?.text = article.title
            cell.detailTextLabel?.text = article.description
            cell.detailTextLabel?.numberOfLines = 2
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let article = articleManager.getArticle(at: indexPath.row) {
            print("Выбрана новость: \(article.title)")
            // Здесь будет переход на детальный экран
        }
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

