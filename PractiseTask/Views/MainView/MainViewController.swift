//
//  ViewController.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import UIKit

enum SortOptions: String {
    case `default` = "By Default"
    case date = "By Date"
    case likes = "By Likes"
}

final class MainViewController: UIViewController {
    
    let table = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    
    var viewModel: MainViewModel = MainViewModel()
    
    var cellDataSource: [PostCellViewModel] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViewModel()
        viewModel.getData()
    }
        
    private func configure() {
        view.backgroundColor = .white
        title = "Home"
        
        setUpTableView()
        setUpActivityIndicator()
        setUpSortButton()
    }
    
    // MARK: - SetUps
    private func setUpTableView() {
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        table.dataSource = self
        table.delegate = self
        table.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        table.register(PostCellWithoutButton.self, forCellReuseIdentifier: PostCellWithoutButton.identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
  
        activityIndicator.center = view.center
    }

    private func setUpSortButton() {
        let sortByDefault = UIAction(title: SortOptions.default.rawValue) { _ in
            self.viewModel.sortPosts(sortOption: .default)
        }
        
        let sortByDate = UIAction(title: SortOptions.date.rawValue) { _ in
            self.viewModel.sortPosts(sortOption: .date)
        }
        
        let sortByLikes = UIAction(title: SortOptions.likes.rawValue) { _ in
            self.viewModel.sortPosts(sortOption: .likes)
        }
        
        let menu = UIMenu(
            title: "Sort",
            options: .displayInline,
            children: [sortByDefault, sortByDate, sortByLikes]
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: .rightNavButton),
            menu: menu
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    // MARK: - Binds
    private func bindViewModel() {
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
        
        viewModel.cellDataSource.bind { [weak self] posts in
            guard let strongSelf = self, let posts = posts else {
                return
            }
            strongSelf.cellDataSource = posts
            strongSelf.reloadTableView()
        }
    }
}
