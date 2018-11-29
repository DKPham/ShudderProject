//
//  WatchedController.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

class WatchedController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Watched"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Watched"
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)
    }

}
