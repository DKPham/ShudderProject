//
//  CustomMenuHeaderView.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.07390641421, green: 0.1373959482, blue: 0.1972886324, alpha: 1)
        setupComponents()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupComponents() {
        nameLabel.text = "Tuie Pham"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        nameLabel.textColor = .white
        emailLabel.text = "duypham701@yahoo.com"
        emailLabel.textColor = .white
        //statsLabel.text = "5 Watched 10 Wishlists"
        profileImageView.image = UIImage(named: "girl_profile")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .red
        
        setupStatsAttributedText()
    }
    
    fileprivate func setupStatsAttributedText() {
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "5 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "Watched  ", attributes: [.foregroundColor: UIColor.red]))
        attributedText.append(NSAttributedString(string: "10 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium), .foregroundColor: UIColor.white]))
        attributedText.append(NSAttributedString(string: "Wishlists", attributes: [.foregroundColor: UIColor.red]))
        
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        let rightSpacerView = UIView()
        let arrangedSubviews = [
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            emailLabel,
            SpacerView(space: 16),
            statsLabel
        ]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
}

