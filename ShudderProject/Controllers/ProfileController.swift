//
//  ProfileController.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
    
}

class ProfileController: UITableViewController {
    
    let profileItems = [
        MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Home"),
        MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "Watched"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmarks"), title: "Wishlists"),
        MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "LogOut")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.07390641421, green: 0.1373959482, blue: 0.1972886324, alpha: 1)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileCell(style: .default, reuseIdentifier: "cellId")
        let profileItem = profileItems[indexPath.row]
        cell.iconImageView.image = profileItem.icon
        cell.titleLabel.text = profileItem.title
        cell.titleLabel.textColor = .white
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderView = CustomMenuHeaderView()
        return customHeaderView
    }
}
