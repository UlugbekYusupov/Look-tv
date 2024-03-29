//
//  ImageView.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

let width: CGFloat = 150
let height: CGFloat = 115

class ViewA: UIView {
    
    let firstImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let secondImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let thirdImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let fourthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let fifthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let sixthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .init(red: 255/255, green: 116/255, blue: 113/255, alpha: 1)
        setupImageViewsA()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupImageViewsA() {
        addSubview(firstImageView)
        addSubview(secondImageView)
        addSubview(thirdImageView)
        addSubview(fourthImageView)
        addSubview(fifthImageView)
        addSubview(sixthImageView)
        
        firstImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 300, height: height)
        
        secondImageView.anchor(top: firstImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        thirdImageView.anchor(top: firstImageView.bottomAnchor, left: secondImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        fourthImageView.anchor(top: topAnchor, left: firstImageView.rightAnchor, bottom: nil, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: height)
        
        fifthImageView.anchor(top: fourthImageView.bottomAnchor, left: thirdImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        sixthImageView.anchor(top: topAnchor, left: fifthImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 0, height: 0)
        
    }
    
}

class ViewB: UIView {
    
    let firstImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let secondImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let thirdImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let fourthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let fifthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    let sixthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .init(red: 255/255, green: 116/255, blue: 113/255, alpha: 1)
        backgroundColor = .clear
        layer.cornerRadius = 8
        setupImageViewsB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupImageViewsB() {
        addSubview(firstImageView)
        addSubview(secondImageView)
        addSubview(thirdImageView)
        addSubview(fourthImageView)
        addSubview(fifthImageView)
        addSubview(sixthImageView)
        
        firstImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        secondImageView.anchor(top: topAnchor, left: firstImageView.rightAnchor, bottom: nil, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: height)
        
        thirdImageView.anchor(top: secondImageView.bottomAnchor, left: firstImageView.rightAnchor, bottom: bottomAnchor   , right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        fourthImageView.anchor(top: topAnchor, left: thirdImageView.rightAnchor, bottom: nil, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: height)
        
        fifthImageView.anchor(top: topAnchor, left: fourthImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 0, height: height)
        
        sixthImageView.anchor(top: fifthImageView.bottomAnchor , left: thirdImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 0, height: 0)
    }
}

class ViewC: UIView {
    
    let firstImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        //        iv.layer.cornerRadius = 8
        return iv
    }()
    let secondImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        //        iv.layer.cornerRadius = 8
        return iv
    }()
    let thirdImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        //        iv.layer.cornerRadius = 8
        return iv
    }()
    let fourthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        //        iv.layer.cornerRadius = 8
        return iv
    }()
    let fifthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        //        iv.layer.cornerRadius = 8
        return iv
    }()
    let sixthImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        //        iv.layer.cornerRadius = 8
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        backgroundColor = .init(red: 255/255, green: 116/255, blue: 113/255, alpha: 1)
        backgroundColor = .clear
        //        layer.cornerRadius = 8
        setupImageViewsA()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupImageViewsA() {
        addSubview(firstImageView)
        addSubview(secondImageView)
        addSubview(thirdImageView)
        addSubview(fourthImageView)
        addSubview(fifthImageView)
        addSubview(sixthImageView)
        
        firstImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: height)
        
        secondImageView.anchor(top: firstImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        thirdImageView.anchor(top: topAnchor, left: firstImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        fourthImageView.anchor(top: topAnchor, left: thirdImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 0, height: height)
        
        fifthImageView.anchor(top: fourthImageView.bottomAnchor, left: thirdImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: width, height: 0)
        
        sixthImageView.anchor(top: fourthImageView.bottomAnchor, left: fifthImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 0, height: 0)
    }
    
}

func showAlertView() {
    
    let downloadAlertView = UIView()
    let alertView = UIView()
    let headerView = UIView()
    
    
    let rootView = UIApplication.shared.keyWindow
    rootView?.addSubview(downloadAlertView)
    downloadAlertView.anchor(top: rootView?.topAnchor, leading: rootView?.leadingAnchor, bottom: rootView?.bottomAnchor, trailing: rootView?.trailingAnchor)
    
    downloadAlertView.backgroundColor = UIColor(white: 0, alpha: 0.4)
    
    downloadAlertView.addSubview(alertView)
    alertView.backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
    
    alertView.centerInSuperview()
    alertView.anchor(top: nil, leading: downloadAlertView.leadingAnchor, bottom: nil, trailing: downloadAlertView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 230))
    
    alertView.addSubview(headerView)
    headerView.anchor(top: alertView.topAnchor, leading: alertView.leadingAnchor, bottom: nil, trailing: alertView.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 10))
    
    print(alertView.bounds)
    
    headerView.backgroundColor = .red
    
    let gradient = CAGradientLayer()
    
    gradient.frame = CGRect(x: 0, y: 0, width: 315, height: 10)
    
    let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
    let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
    
    gradient.colors = [leftColor.cgColor, rightColor.cgColor]
    gradient.startPoint = CGPoint(x: 0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    headerView.layer.insertSublayer(gradient, at: 0)
}


let userImageView: UIImageView = {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = .blue
    iv.layer.cornerRadius = 5
    return iv
}()

let emailIDLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "kkh77039806@giitd.net"
    label.font = UIFont(name: "Myanmar Sangam MN", size: 12)
    label.clipsToBounds = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.3
    label.contentMode = .scaleAspectFill
    return label
}()
