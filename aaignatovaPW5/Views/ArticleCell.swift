//
//  ArticleCell.swift
//  aaignatovaPW5
//
//  Created by Anzhelika Ignatova on 10.02.2026.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            // Image constraints
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            articleImageView.widthAnchor.constraint(equalToConstant: 80),
            articleImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Stack constraints
            stackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
        
        selectionStyle = .default
        accessoryType = .disclosureIndicator
    }
    
    // MARK: - Configuration
    func configure(with article: ArticleModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.announce
        
        if let imageURL = article.img?.url {
            loadImage(from: imageURL)
        } else {
            articleImageView.image = nil
        }
    }
    
    // MARK: - Image Loading
    private func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                }
            }
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
}
