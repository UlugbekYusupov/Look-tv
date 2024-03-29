//
//  FirstCollectionCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/3/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class FirstCollectionCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
