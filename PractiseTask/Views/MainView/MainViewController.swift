//
//  ViewController.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let table = UITableView()
    let activityIndicator = UIActivityIndicatorView()
    
    // ViewModel
    var viewModel: MainViewModel = MainViewModel()
    
    var cellDataSource: [PostCellViewModel] = []

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
        let sortByDefault = UIAction(title: "By Default") { _ in
            self.viewModel.mapCellData()
            self.reloadTableView()
        }
        
        let sortByDate = UIAction(title: "By Date", image: nil) { _ in
            self.cellDataSource.sort(by: { $0.postDate < $1.postDate })
            self.reloadTableView()
        }
        
        let sortByLikes = UIAction(title: "By Likes", image: nil) { _ in
            self.cellDataSource.sort(by: { $0.likesCount > $1.likesCount })
            self.reloadTableView()
        }
        
        let menu = UIMenu(title: "Sort", options: .displayInline, children: [sortByDefault, sortByDate, sortByLikes])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.and.down.text.horizontal"), menu: menu)
        navigationItem.rightBarButtonItem?.tintColor = .black
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
        
        viewModel.cellDataSource.bind { [weak self] posts in
            guard let strongSelf = self, let posts = posts else {
                return
            }
            strongSelf.cellDataSource = posts
            strongSelf.reloadTableView()
        }
    }
}
