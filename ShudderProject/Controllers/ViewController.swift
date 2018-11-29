//
//  ViewController.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/27/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

class FeaturedController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    private let cellId = "cellId"
    private let headerId = "headerId"
    
    var moviesCategories: [MovieCategory]?
    var featuredMovies: FeaturedMovies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SHUDDER"
        setupNavigationItems()
        navigationController?.navigationBar.installBlurEffect()
        MovieCategory.fetchFeaturedMovies { (featuredMovies) in
            self.featuredMovies = featuredMovies
            self.moviesCategories = featuredMovies.moviesCategories
            self.collectionView.reloadData()
        }
        collectionView.backgroundColor = #colorLiteral(red: 0.07390641421, green: 0.1373959482, blue: 0.1972886324, alpha: 1)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func showMovieDetailForMovie(movie: Movie) {
        let layout = UICollectionViewFlowLayout()
        let movieDetailController = MovieDetailController(collectionViewLayout: layout)
        movieDetailController.movie = movie
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    fileprivate func setupNavigationItems() {
        let image = #imageLiteral(resourceName: "girl_profile").withRenderingMode(.alwaysOriginal)
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let barButtomItem = UIBarButtonItem(customView: customView)
        navigationItem.leftBarButtonItem = barButtomItem
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openProfile()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = moviesCategories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.movieCategory = moviesCategories?[indexPath.item]
        cell.featuredMoviesController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        header.movieCategory = featuredMovies?.bannerCategory
        return header
    }
}

extension UINavigationBar {
    func installBlurEffect() {
        isTranslucent = true
        setBackgroundImage(UIImage(named: "shudder"), for: .default)
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        var blurFrame = bounds
        blurFrame.size.height += statusBarHeight
        blurFrame.origin.y -= statusBarHeight
        let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.isUserInteractionEnabled = false
        blurView.frame = blurFrame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        blurView.layer.zPosition = -1
    }
}

extension FeaturedController {
    
    func setupNavigationBarItems() {
        setupLeftNavItem()
        setupRightNavItems()
    }
    
    private func setupLeftNavItem() {
        let menuButton = UIButton(type: .system)
        menuButton.setImage(#imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), for: .normal)
        menuButton.tintColor = .white
        menuButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    private func setupRightNavItems() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
}

