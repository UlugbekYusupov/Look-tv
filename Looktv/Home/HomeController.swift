//
//  HomeController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/3/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let backView = UIView()
    
    var status = false
    
    //MARK:- Cell ids
    let cellID = "cellID"
    let headerID = "headerID"
    let footerID = "footerID"
    let firstCellID = "firstCellID"
    
    let tvRecomendationID = "tvRecomendationID"
    let svRecomendationID = "svRecomendationID"
    let continuePlayingID = "continuePlayingID"
    
    static let shared = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
    
    var presentHandler: ( (FeaturedList_Lists, IndexPath) -> () )?
    
    var tvPresentHandler: ( (TV_SV_List, IndexPath) -> () )?
    var svPresentHandler: ( (TV_SV_List, IndexPath) -> () )?
    
    var tvseemoreHandler: (()->())?
    var svseemorHandler: (()->())?
    
    //MARK:- viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        tvRecomendationCell.shared.seemoreHandle = {
            print("fsdfmnskjd")
            self.tvseemoreHandler?()
        }
    }
    
    //MARK:- collectionView Cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if status == false {
            return 3
        }
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            collectionView.register(FirstCell.self, forCellWithReuseIdentifier: firstCellID)
            let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellID, for: indexPath) as! FirstCell
            
            firstCell.firstCellController.didSelectHandler = { featuredList, indexPath in
                
                self.presentHandler?(featuredList, indexPath)
            }
            
            return firstCell
        }
        
        if indexPath.row == 1 {
            collectionView.register(tvRecomendationCell.self, forCellWithReuseIdentifier: tvRecomendationID)
            let tvCell = collectionView.dequeueReusableCell(withReuseIdentifier: tvRecomendationID, for: indexPath) as! tvRecomendationCell
            tvCell.horizontalController.didSelectHandler = { tvRecommend, indexPath in
                self.tvPresentHandler!(tvRecommend, indexPath)
            }
            
            return tvCell
        }
        
        if status == false {
           
            if indexPath.row == 2 {
                collectionView.register(svRecomendationCell.self, forCellWithReuseIdentifier: svRecomendationID)
                let svCell = collectionView.dequeueReusableCell(withReuseIdentifier: svRecomendationID, for: indexPath) as! svRecomendationCell
                svCell.horizontalController.didSelectHandler = { svRecommend, indexPath in
                    self.svPresentHandler!(svRecommend, indexPath)
                }
                return svCell
            }
            
        }
            
        else {
            if indexPath.row == 3 {
                collectionView.register(svRecomendationCell.self, forCellWithReuseIdentifier: svRecomendationID)
                let svCell = collectionView.dequeueReusableCell(withReuseIdentifier: svRecomendationID, for: indexPath) as! svRecomendationCell
                svCell.horizontalController.didSelectHandler = { svRecommend, indexPath in
                    self.svPresentHandler!(svRecommend, indexPath)
                }
                return svCell
            }
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height: 210)
        }
        return CGSize(width: view.frame.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK:- collectionView Header Cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath) as! FooterCell
        return footer

    }
    
    //MARK:- collectionView Footer Cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    //MARK:- setup methods
    fileprivate func setupCollectionViews() {
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.showsVerticalScrollIndicator = false
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        backView.layer.insertSublayer(gradient, at: 0)
        
        collectionView.backgroundView = backView
    }
}
