//
//  PackageCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/24/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class PackageCell: UITableViewCell {
    
    //MARK:- instance vars
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let playImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "btn_play_icon")
        image.clipsToBounds = true
        return image
    }()
    let downloadImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "btn_download_icon")
        image.clipsToBounds = true
        return image
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "DOWNLOAD"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    let playLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "PLAY"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "icon_category_open"), for: .normal)
        return button
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 14)
        return label
    }()
    
    
    let formattedDurationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "fmdslkfmsdjf"
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1139442846, green: 0.8979282379, blue: 0.4395103753, alpha: 1)
        return view
    }()
    
    let star1ImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "icon_star_main_green_f").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let star2ImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "icon_star_main_green_f").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let star3ImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "icon_star_main_green_f").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let star4ImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "icon_star_main_green_f").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let star5ImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "icon_star_main_green_f").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    //MARK:- init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 0))
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 0.5))
        
        setupButtons()
        setupStar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- setup methods
    fileprivate func setupButtons() {
        
        addSubview(playButton)
        playButton.anchor(top: nil, leading: nil, bottom: lineView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 15), size: CGSize(width: 80, height: 23))
        playButton.layer.cornerRadius = 2
        
        addSubview(downloadButton)
        downloadButton.anchor(top: nil, leading: nil, bottom: lineView.topAnchor, trailing: playButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 10), size: CGSize(width: 80, height: 23))
        downloadButton.layer.cornerRadius = 2
        
        downloadButton.addSubview(downloadImage)
        downloadImage.anchor(top: downloadButton.topAnchor, leading: downloadButton.leadingAnchor, bottom: downloadButton.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        
        playButton.addSubview(playImage)
        playImage.anchor(top: playButton.topAnchor, leading: playButton.leadingAnchor, bottom: playButton.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        
        playButton.addSubview(playLabel)
        playLabel.anchor(top: playButton.topAnchor, leading: playImage.trailingAnchor, bottom: playButton.bottomAnchor, trailing: playButton.trailingAnchor, padding: .init(top: 5, left: 8, bottom: 5, right: 0))
        
        downloadButton.addSubview(downloadLabel)
        downloadLabel.anchor(top: downloadButton.topAnchor, leading: downloadImage.trailingAnchor, bottom: downloadButton.bottomAnchor, trailing: downloadButton.trailingAnchor, padding: .init(top: 6, left: 3, bottom: 5, right: 0))
    }
    
    fileprivate func setupStar() {
        let stackView = UIStackView(arrangedSubviews: [star1ImageView,star2ImageView,star3ImageView,star4ImageView,star5ImageView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addSubview(stackView)
        stackView.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 60, height: 10))
        
        
        addSubview(formattedDurationLabel)
        formattedDurationLabel.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: lineView.topAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
        addSubview(releaseYearLabel)
        releaseYearLabel.anchor(top: formattedDurationLabel.topAnchor, leading: formattedDurationLabel.trailingAnchor, bottom: lineView.topAnchor, trailing: nil, padding: .init(top: 0, left: 5, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    //MARK:- handle methods
//    var userStatus: Bool = false
//
//    @objc func handleDownload() {
//
//        if userStatus {
//            let loginController = LoginController()
//            present(loginController, animated: true)
//        }
//
//        else {
//            showAlertView()
//        }
//    }
//
//    @objc func handlePlay() {
//
//        if userStatus {
//            let loginController = LoginController()
//            present(loginController, animated: true)
//        }
//
//        else {
//            showAlertView()
//        }
//    }
}
