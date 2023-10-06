//
//  MainViewController+TableView.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellDataSource[indexPath.row].previewText.countLines(self.view) > 2 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostCell.identifier,
                for: indexPath
            ) as? PostCell else {
                return UITableViewCell()
            }
            cell.onExpandDidTap { [weak self] in
                self?.cellDataSource[indexPath.row].isExpand.toggle()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            let postViewModel = cellDataSource[indexPath.row]
            cell.setupCell(viewModel: postViewModel)
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostCellWithoutButton.identifier,
            for: indexPath
        ) as? PostCellWithoutButton else {
            return UITableViewCell()
        }

        let postViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: postViewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
