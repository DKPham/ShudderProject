//
//  MovieDetailController.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import UIKit

class MovieDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var movie: Movie? {
        didSet {
//            //nameLabel.text = movie?.title
//            let apiKey = "509a8e665b1617b163b06d6c281400fb"
//            if let id = movie?.id {
//                let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US"
//                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
//
//                    if error != nil {
//                        print(error ?? "")
//                        return
//                    }
//
//                    do {
//                        guard let data = data else { return }
//                        let movieDetail = try JSONDecoder().decode(Movie.self, from: data)
//                        self.movie = movieDetail
//
//                        DispatchQueue.main.async(execute: { () -> Void in
//                            self.collectionView?.reloadData()
//                        })
//
//                    } catch let err {
//                        print(err)
//                    }
//                }).resume()
//            }
        }
    }
    
    private let headerId = "headerId"
    private let cellId = "cellId"
    private let descriptionCellId = "descriptionCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.07390641421, green: 0.1373959482, blue: 0.1972886324, alpha: 1)
        collectionView.alwaysBounceVertical = true
        collectionView.register(MovieDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(MovieDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Overview\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
        
        if let desc = movie?.overview {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightText]))
        }
        
        return attributedText
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! MovieDetailDescriptionCell
        cell.textView.attributedText = descriptionAttributedText()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        return CGSize(width: view.frame.width, height: 600)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MovieDetailHeader
        header.movie = movie
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}

class MovieDetailHeader: BaseCell {
    
    var movie: Movie? {
        didSet {
            let url = URL(string: movie?.imageUrl?.toSecureHTTPS() ?? "")
            imageView.sd_setImage(with: url)
        }
    }
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override func setupView() {
        super.setupView()
        clipsToBounds = false
        //backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath

        addSubview(imageView)

        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)

    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}
