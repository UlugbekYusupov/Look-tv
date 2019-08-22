//
//  svRecomendationCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class svRecomendationCell: UICollectionViewCell {
    
    //MARK:- instance variables
    let recomendationLabel = UILabel(text: "SVOD: Recommendation", font: .boldSystemFont(ofSize: 14), color: #colorLiteral(red: 0.7348398566, green: 0.7353639603, blue: 0.7457178235, alpha: 1))
    
    let horizontalController = svRecomendationController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let seemoreButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .center
        button.backgroundColor = #colorLiteral(red: 0.1724897921, green: 0.1819442213, blue: 0.2236489654, alpha: 1)
        button.setTitle("see more", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana", size: 10)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        button.layer.cornerRadius = 3
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsAndControllers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- setupViewsAndControllers
    
    fileprivate func setupViewsAndControllers() {
        backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        
        addSubview(recomendationLabel)
        addSubview(horizontalController.view)
        addSubview(seemoreButton)

        recomendationLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, paddingTop: 25, width: 0, height: 0)
        
        horizontalController.view.anchor(top: recomendationLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        seemoreButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 30), size: CGSize(width: 70, height: 18))
        seemoreButton.addTarget(self, action: #selector(handleSeemore), for: .touchUpInside)
    }
    
    @objc fileprivate func handleSeemore() {
        print("sv seemore tapped")
    }
}
