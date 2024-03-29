//
//  FirstCellHorizontalController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/3/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit
import SDWebImage

class FirstCellHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    static let shared = FirstCellHorizontalController()
   
    let transparentView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textColor = .white
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .green
        pc.pageIndicatorTintColor = .white
        return pc
    }()
    
    let cellID = "cellID"
    
    //MARK:- viewDidLoad method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(FirstCollectionCell.self, forCellWithReuseIdentifier: cellID)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        fetch()
        setupLabelView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    //MARK:- CollectionView override methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.featureListResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FirstCollectionCell
        
        let featuredList = featureListResult[indexPath.item]
        let imageUrl = URL(string: featuredList.posterLandscapeUrl)
        cell.imageView.sd_setImage(with: imageUrl)
        
        pageControl.numberOfPages = featureListResult.count
        
        titleLabel.text = featureListResult[0].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    var didSelectHandler: ((FeaturedList_Lists, IndexPath) -> ())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let featuredList = featureListResult[indexPath.item]
        didSelectHandler?(featuredList, indexPath)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let xvalue = scrollView.contentOffset.x
        let width = collectionView.bounds.width
        let cellIndex = xvalue / width

        self.titleLabel.text = self.featureListResult[Int(round(cellIndex))].name
    }
    
    fileprivate var featureListResult = [FeaturedList_Lists]()
    
    fileprivate func fetch() {
        APIService.shared.featuredList_fetch { (results, err) in
            
            if let err = err {
                print("Failed to fetch: ", err)
                return
            }
            self.featureListResult = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setupLabelView() {
        
        view.addSubview(transparentView)
        
        transparentView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        transparentView.backgroundColor = #colorLiteral(red: 0.005934356712, green: 0.6021594405, blue: 0.7530459166, alpha: 1)
        transparentView.alpha = 0.7
        transparentView.isUserInteractionEnabled = true
        
        
        transparentView.addSubview(titleLabel)
        
        titleLabel.anchor(top: transparentView.topAnchor, leading: transparentView.leadingAnchor, bottom: transparentView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 15, bottom: 15, right: 0), size: CGSize(width: 300, height: 0))
        
        transparentView.addSubview(pageControl)
        pageControl.centerXInSuperview()
        pageControl.anchor(top: nil, leading: nil, bottom: transparentView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 20))
    }
    
    
}
