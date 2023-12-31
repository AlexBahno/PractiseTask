//
//  PostCellWithoutButton.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 06.10.2023.
//

import Foundation
import UIKit

final class PostCellWithoutButton: UITableViewCell {
    
    private let stackView = UIStackView()
    private let likesAndDateView = UIStackView()
    private let title = UILabel()
    private let previewText = UILabel()
    private let likesCount = UILabel()
    private let postDate = UILabel()
        
    public static var identifier: String {
        get {
            "PostCellWithoutButton"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        previewText.text = nil
        likesCount.text = nil
        postDate.text = nil
    }
    
    private func configure() {
        setupStackView()
        setupTitleLabel()
        setupPreviewTextLabel()
        setupLikesAndDateView()
        setupLikesCount()
        setupPostDate()
    }
    
    // MARK: - SetUps
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        title.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(title)
        
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.numberOfLines = 0
        title.textColor = .title
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 15),
            title.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPreviewTextLabel() {
        previewText.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(previewText)
        
        previewText.numberOfLines = 2
        previewText.font = .systemFont(ofSize: 17)
        previewText.textColor = .text
        
        NSLayoutConstraint.activate([
            previewText.topAnchor.constraint(equalTo: title.bottomAnchor),
            previewText.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            previewText.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupLikesAndDateView() {
        likesAndDateView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(likesAndDateView)
        
        likesAndDateView.axis = .horizontal
        
        NSLayoutConstraint.activate([
            likesAndDateView.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 15),
            likesAndDateView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            likesAndDateView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
    
    private func setupLikesCount() {
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        likesAndDateView.addArrangedSubview(likesCount)
        
        likesCount.font = .systemFont(ofSize: 17)
        likesCount.textColor = .text
        
        NSLayoutConstraint.activate([
            likesCount.topAnchor.constraint(equalTo: likesAndDateView.topAnchor),
            likesCount.leadingAnchor.constraint(equalTo: likesAndDateView.leadingAnchor, constant: 20),
            likesCount.bottomAnchor.constraint(equalTo: likesAndDateView.bottomAnchor)
        ])
    }
    
    private func setupPostDate() {
        postDate.translatesAutoresizingMaskIntoConstraints = false
        likesAndDateView.addArrangedSubview(postDate)
        
        postDate.font = .systemFont(ofSize: 17)
        postDate.textAlignment = .right
        postDate.textColor = .text

        NSLayoutConstraint.activate([
            postDate.topAnchor.constraint(equalTo: likesAndDateView.topAnchor),
            postDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            postDate.bottomAnchor.constraint(equalTo: likesAndDateView.bottomAnchor)
        ])
    }
        
    func setupCell(viewModel: PostCellViewModel) {
        self.title.text = viewModel.title
        self.previewText.text = viewModel.previewText
        self.likesCount.text = "♥️ \(viewModel.likesCount)"
        self.postDate.text = "\(viewModel.postDate) day ago"
    }
}
