//
//  CategoryCell.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/27/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var featuredMoviesController: FeaturedController?
    
    var movieCategory: MovieCategory? {
        didSet {
            if let name = movieCategory?.name {
                sectionLabel.text = name
            }
            moviesCollectionView.reloadData()
        }
    }
    
    private let cellId = "movieCellId"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.textColor = .white
        //label.font = UIFont.(name: "Roboto Condensed", size: 16)
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(moviesCollectionView)
        addSubview(sectionLabel)
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": sectionLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": moviesCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sectionLabel(30)][v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": moviesCollectionView, "sectionLabel": sectionLabel]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = movieCategory?.movies?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        cell.movie = movieCategory?.movies?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movieCategory?.movies?[indexPath.item] {
            featuredMoviesController?.showMovieDetailForMovie(movie:  movie)
        }
    }

}

class MovieCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            let url = URL(string: movie?.imageUrl?.toSecureHTTPS() ?? "")
            imageView.sd_setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        //backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        setupView()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        //imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
}
