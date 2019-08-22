//
//  TvScheduleCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/5/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class TvScheduleCell: UITableViewCell {
    
    let timeView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        return v
    }()
    
    let lineView = UIView()
    
    let scheduleTime: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "21:2"
        label.textColor = .white
        label.backgroundColor = .brown
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont(name: "Verdana", size: 13)
//        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
//        label.minimumScaleFactor = 0.5
        label.textColor = .white
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        
        addSubview(timeView)
        timeView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(), size: CGSize(width: 70, height: 0))
        
        timeView.addSubview(scheduleTime)
        scheduleTime.centerInSuperview()
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: timeView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        lineView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, leading: timeView.trailingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 8, bottom: 5, right: 0), size: CGSize(width: self.frame.width, height: self.frame.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
