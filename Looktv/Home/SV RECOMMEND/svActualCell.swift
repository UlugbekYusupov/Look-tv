//
//  svActualCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class svActualCell: UICollectionViewCell {
    
    let view = ViewA()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1139442846, green: 0.8979282379, blue: 0.4395103753, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(view)
        addSubview(lineView)
        
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
        lineView.anchor(top: view.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
