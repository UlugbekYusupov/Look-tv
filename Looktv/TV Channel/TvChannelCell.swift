//
//  TvChannelCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/1/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class TvChannelCell: UITableViewCell {
    
    let lineView = UIView()
    
    let channelImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        return iv
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        label.text = "FHKSFJHKDS"
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 13)
        label.clipsToBounds = true
//        label.backgroundColor = .red
        label.numberOfLines = 3
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        
        addSubview(channelImageView)
        channelImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 7, left: 5, bottom: 7, right: 0), size: CGSize(width: 75, height: 0))
        
        addSubview(channelLabel)
        channelLabel.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 280, height: 0))
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        lineView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
