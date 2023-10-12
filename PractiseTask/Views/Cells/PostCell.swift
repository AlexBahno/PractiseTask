//
//  TableViewCell.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import UIKit

final class PostCell: UITableViewCell {
    
    private let stackView = UIStackView()
    private let likesAndDateView = UIStackView()
    private let title = UILabel()
    private let previewText = UILabel()
    private let likesCount = UILabel()
    private let postDate = UILabel()
    private let expandButton = UIButton(type: .system)
    
    var isExpand = false
    var expandDidTapHandler: (() -> Void)?
    
    public static var identifier: String {
        get {
            "PostCell"
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
        isExpand = false
    }
    
    private func configure() {
        setupStackView()
        setupTitleLabel()
        setupPreviewTextLabel()
        setupLikesAndDateView()
        setupLikesCount()
        setupPostDate()
        setupExpandButton()
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
            previewText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
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
            likesAndDateView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
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
    
    private func setupExpandButton() {
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(expandButton)
        
        expandButton.setTitle("Expand", for: .normal)
        expandButton.setTitleColor(.white, for: .normal)
        expandButton.backgroundColor = .buttonBackground
        expandButton.titleLabel?.font = .systemFont(ofSize: 17)
        expandButton.addTarget(self, action: #selector(expandPost), for: .touchUpInside)
        expandButton.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            expandButton.topAnchor.constraint(equalTo: likesAndDateView.layoutMarginsGuide.bottomAnchor, constant: 20),
            expandButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            expandButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            expandButton.heightAnchor.constraint(equalToConstant: 50),
            expandButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    @objc private func expandPost() {
        self.isExpand.toggle()
        self.previewText.numberOfLines = self.isExpand ? 0 : 2
        self.previewText.layoutIfNeeded()
        self.expandButton.setTitle(self.isExpand ? "Collapse" : "Expand", for: .normal)
        self.expandDidTapHandler?()
    }
    
    func onExpandDidTap(_ handler: @escaping () -> Void) {
        self.expandDidTapHandler = handler
    }
    
    func setupCell(viewModel: PostCellViewModel) {
        self.title.text = viewModel.title
        self.previewText.text = viewModel.previewText
        self.likesCount.text = "♥️ \(viewModel.likesCount)"
        self.postDate.text = "\(viewModel.postDate) day ago"
        
        self.isExpand = viewModel.isExpand
        self.expandButton.setTitle(self.isExpand ? "Collapse" : "Expand", for: .normal)
    }
}
