//
//  BaseSlidingController.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class ProfileContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingController: UIViewController {

    let redView: RightContainerView = {
        let v = RightContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: ProfileContainerView = {
        let v = ProfileContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkCoverView = {
        let v = DarkCoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        
        // how do we translate our red view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleTapDismiss() {
        closeProfile()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isProfileOpened ? x + profileWidth : x
        x = min(profileWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / profileWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isProfileOpened {
            if velocity.x < -velocityThreshold {
                closeProfile()
                return
            }
            if abs(translation.x) < profileWidth / 2 {
                openProfile()
            } else {
                closeProfile()
            }
        } else {
            if velocity.x > velocityThreshold {
                openProfile()
                return
            }
            
            if translation.x < profileWidth / 2 {
                closeProfile()
            } else {
                openProfile()
            }
        }
    }
    
    func openProfile() {
        isProfileOpened = true
        redViewLeadingConstraint.constant = profileWidth
        redViewTrailingConstraint.constant = profileWidth
        performAnimations()
    }
    
    func closeProfile() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        isProfileOpened = false
        performAnimations()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        performRightViewCleanUp()
        closeProfile()
        
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: FeaturedController())
        case 1:
            rightViewController = UINavigationController(rootViewController: WatchedController())
        case 2:
            rightViewController = WishlistsController()
        default:
            print("Featured")
        }
        
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        redView.bringSubviewToFront(darkCoverView)
    }
    
    var rightViewController: UIViewController = UINavigationController(rootViewController: FeaturedController(collectionViewLayout: UICollectionViewFlowLayout()))
    
    fileprivate func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isProfileOpened ? 1 : 0
        })
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    fileprivate let profileWidth: CGFloat = 300
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate var isProfileOpened = false
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        // let's go ahead and use Auto Layout
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: profileWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let profileController = ProfileController()
        
        let homeView = rightViewController.view!
        let profileView = profileController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            // top, leading, bottom, trailing anchors
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            profileView.topAnchor.constraint(equalTo: blueView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            profileView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            profileView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            ])
        
        addChild(rightViewController)
        addChild(profileController)
    }

}
