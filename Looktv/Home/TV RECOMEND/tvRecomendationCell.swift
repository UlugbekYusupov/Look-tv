//
//  tvRecomendationCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class tvRecomendationCell: UICollectionViewCell {

    
    //MARK:- instance variables
    
    static let shared = tvRecomendationCell()
    
    let recomendationLabel = UILabel(text: "TVOD: Recommendation", font: .boldSystemFont(ofSize: 14), color: #colorLiteral(red: 0.7348398566, green: 0.7353639603, blue: 0.7457178235, alpha: 1))
    
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
    
    let horizontalController = tvRecomendationController(collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK:- viewDidLoad
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupControllers()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- setupControllers
    
    var seemoreHandle: ( ()->() )?
    fileprivate func setupControllers() {
        
        backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
//        backgroundColor = .yellow
        addSubview(recomendationLabel)
        addSubview(seemoreButton)
        addSubview(horizontalController.view)

        recomendationLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, paddingTop: 15, width: 0, height: 0)
    
        horizontalController.view.anchor(top: recomendationLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        seemoreButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 30), size: CGSize(width: 70, height: 18))
        seemoreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSeemore)))
    }
    
    @objc fileprivate func handleSeemore() {
        seemoreHandle?()
    }
}
