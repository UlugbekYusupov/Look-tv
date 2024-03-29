//
//  FooterCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class FooterCell: UICollectionViewCell {
    
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
    
    let bottomLogoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "look_bi_white_bottom"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = true
        //        iv.backgroundColor = .red
        return iv
    }()
    
    let phoneImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "icon_phone"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = true
        //        iv.backgroundColor = .red
        return iv
    }()
    
    let emailImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "icon_mail"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = true
        //        iv.backgroundColor = .red
        return iv
    }()
    
    let newsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        return view
    }()
    
    let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "News & Notice"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.7348398566, green: 0.7353639603, blue: 0.7457178235, alpha: 1)
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "1474, 77771474"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = #colorLiteral(red: 0.8867350221, green: 0.887396276, blue: 0.8903012872, alpha: 1)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "support@looktv.mn"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.8867350221, green: 0.887396276, blue: 0.8903012872, alpha: 1)
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5340566039, green: 0.538184762, blue: 0.572317183, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        setupNewsView()
        setupNewsStackView()
        setupFooterItems()
        newsFetch()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupFooterItems() {
        addSubview(bottomLogoImageView)
        bottomLogoImageView.anchor(top: bottomLine.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 8, left: 15, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
        addSubview(emailLabel)
        emailLabel.anchor(top: bottomLine.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 10), size: CGSize(width: 0, height: 0))
        
        addSubview(emailImageView)
        emailImageView.anchor(top: bottomLine.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: emailLabel.leadingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 2), size: CGSize(width: 0, height: 0))
        
        
        addSubview(phoneLabel)
        phoneLabel.anchor(top: bottomLine.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: emailImageView.leadingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 10), size: CGSize(width: 0, height: 0))
        
        addSubview(phoneImageView)
        phoneImageView.anchor(top: bottomLine.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: phoneLabel.leadingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 2), size: CGSize(width: 0, height: 0))
    }

    fileprivate func setupNewsStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [newsLabel,UIView(), titleLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        newsView.addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: newsView.leadingAnchor, bottom: nil, trailing: newsView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    fileprivate func setupNewsView() {
        addSubview(newsView)
        
        newsView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 95))
        
        newsView.addSubview(seemoreButton)
        seemoreButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 30), size: CGSize(width: 70, height: 18))
        
        newsView.addSubview(bottomLine)
        bottomLine.anchor(top: nil, leading: newsView.leadingAnchor, bottom: newsView.bottomAnchor, trailing: newsView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
    }
    
    fileprivate var newsList = [Newslist_List]()
    
    func newsFetch() {
        
        APIService.shared.newsList_fetch { (list, err) in
            if let err = err {
                print("Failed to fetch: ", err)
            }
            guard let list = list else {return}
            
            self.newsList = list
        }
    }
}
