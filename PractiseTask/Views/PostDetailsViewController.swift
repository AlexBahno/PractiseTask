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
    
    let image = ScaledHeightImageView()
    let titleLabel = UILabel()
    let textView = UITextView()
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
        title = "Title"
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
            self.title = post.title
            self.textView.text = post.text
            self.likesCount.text = "♥️ \(post.likesCount ?? 0)"
            self.postDate.text = self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(post.timeshamp ?? 0)))
        }
    }
    
    private func configure() {
        setupImage()
        setupTitle()
        setupText()
        setupLikesCount()
        setupPostDate()
        setUpActivityIndicator()
    }
    
    private func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "photo")
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(lessThanOrEqualToConstant: view.height)
        ])
    }
    
    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = UIColor(red: 72/255, green: 82/255, blue: 94/255, alpha: 1)
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    private func setupText() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        textView.font = .systemFont(ofSize: 17)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isSelectable = false
        textView.textColor = UIColor(red: 133/255, green: 148/255, blue: 168/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75)
        ])
    }
    
    private func setupLikesCount() {
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likesCount)
        
        likesCount.font = .systemFont(ofSize: 15)
        likesCount.textColor = UIColor(red: 133/255, green: 148/255, blue: 168/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            likesCount.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 15),
            likesCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likesCount.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    private func setupPostDate() {
        postDate.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postDate)
        
        postDate.font = .systemFont(ofSize: 15)
        postDate.textColor = UIColor(red: 133/255, green: 148/255, blue: 168/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            postDate.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 15),
            postDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            postDate.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
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
