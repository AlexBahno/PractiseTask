//
//  PostDetailsViewController.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 07.10.2023.
//

import UIKit
import SDWebImage

class PostDetailsViewController: UIViewController {

    var post: Post?
    
    let scrollView = UIScrollView()
    let container = UIStackView()
    var likesAndDateView = UIStackView()
    let image = ScaledHeightImageView()
    let titleLabel = UILabel()
    let textView = UILabel()
    let likesCount = UILabel()
    let postDate = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    
    // viewModel
    var viewModel: PostDetailsViewModel
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    init(viewModel: PostDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .white
        
        configure()
        bindViewModel()
    }
    
    private func setupPost() {
        guard let post = post else {
            return
        }
        DispatchQueue.main.async {
            self.image.sd_setImage(with: URL(string: post.postImage ?? ""))
            self.titleLabel.text = post.title
            self.textView.text = post.text
            self.likesCount.text = "♥️ \(post.likesCount ?? 0)"
            self.postDate.text = self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(post.timeshamp ?? 0)))
        }
    }
    
    private func configure() {
        setupScrollView()
        setupContainer()
        setupImage()
        setupTitle()
        setupText()
        setupLikesAndDateView()
        setupLikesCount()
        setupPostDate()
        setUpActivityIndicator()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)
        
        container.axis = .vertical
        container.spacing = 15
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(image)
        
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "photo")
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = .title
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupText() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(textView)
        
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .text
        textView.numberOfLines = 0
        textView.textAlignment = .left
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            textView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupLikesAndDateView() {
        likesAndDateView.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(likesAndDateView)
        
        likesAndDateView.axis = .horizontal
        likesAndDateView.distribution = .fill
        
        NSLayoutConstraint.activate([
            likesAndDateView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 15),
            likesAndDateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            likesAndDateView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            likesAndDateView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupLikesCount() {
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        likesAndDateView.addArrangedSubview(likesCount)
        
        likesCount.font = .systemFont(ofSize: 15)
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
        
        postDate.font = .systemFont(ofSize: 15)
        postDate.textAlignment = .right
        postDate.textColor = .text
        
        NSLayoutConstraint.activate([
            postDate.topAnchor.constraint(equalTo: likesAndDateView.topAnchor),
            postDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            postDate.bottomAnchor.constraint(equalTo: likesAndDateView.bottomAnchor)
        ])
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
  
        activityIndicator.center = view.center
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let strongSelf = self, let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    strongSelf.activityIndicator.startAnimating()
                } else {
                    strongSelf.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.post.bind { [weak self] post in
            guard let strongSelf = self, let post = post else {
                return
            }
            strongSelf.post = post
            strongSelf.setupPost()
        }
    }
}
