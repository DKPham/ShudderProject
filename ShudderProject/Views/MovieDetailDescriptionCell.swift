//
//  MovieDetailDescriptionCell.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

class MovieDetailDescriptionCell: BaseCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = #colorLiteral(red: 0.07390641421, green: 0.1373959482, blue: 0.1972886324, alpha: 1)
        tv.text = "SAMPLE DESCRIPTION"
        return tv
    }()
    
//    let dividerLineView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
//        return view
//    }()
//
    override func setupView() {
        super.setupView()
        
        addSubview(textView)
        //addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        //addConstraintsWithFormat(format: "H:|-14-[v0]|", views: dividerLineView)
        
        //addConstraintsWithFormat(format: "V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: textView)
    }
}
