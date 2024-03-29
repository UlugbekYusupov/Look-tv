//
//  RootController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/10/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

let textFont: UIFont = UIFont(name: "Helvetica Neue", size: 15)!

extension UISegmentedControl {
    
    func customizeAppearance(for height: Int) {
        
        setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name:"Helvetica Neue", size:15)!,NSAttributedString.Key.foregroundColor:UIColor.white], for:.normal)
        
        setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name:"Helvetica Neue", size:15)!,NSAttributedString.Key.foregroundColor:UIColor.white], for:.selected)
        
        setDividerImage(UIImage().colored(with: .clear, size: CGSize(width: 1, height: height)), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        setBackgroundImage(UIImage().colored(with: .clear, size: CGSize(width: 1, height: height)), for: .normal, barMetrics: .default)
        
        setBackgroundImage(UIImage().colored(with: .clear , size: CGSize(width: 1, height: height)), for: .selected, barMetrics: .default);
        
        for  borderview in subviews {
            let upperBorder: CALayer = CALayer()
            upperBorder.backgroundColor = UIColor.init(red: 215/255.0, green: 0.0, blue: 30/255.0, alpha: 1.0).cgColor
            upperBorder.frame = CGRect(x: 0, y: borderview.frame.size.height-1, width: borderview.frame.size.width, height: 1)
            borderview.layer.addSublayer(upperBorder)
        }
        
    }
}

extension UIImage {
    func colored(with color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}

class RootController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {

    //MARK:- private objects
    
    fileprivate let menuWidth: CGFloat = 280
    fileprivate var isMenuOpen = false
    fileprivate let velocityThreshold: CGFloat = 500
    
    var scrollView: UIScrollView!
    
    //MARK:- Controllers creation
    let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
    let tvodController = TVODController()
    let packageTypeSingleViewController = PackageTypeSingleViewController()
    let tvsvSinngleViewController = tvsvSingleViewController()
    let animatedSingleViewController = AnimatedSingleViewController()
    lazy var tvChannelController = TvChannelController()
    
    static let shared = RootController()
    //MARK:- header objects
    let headerlogoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "look_bi_white_top"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.005934356712, green: 0.6021594405, blue: 0.7530459166, alpha: 1)
        return view
    }()
    
    
    let optionsButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
//        button.backgroundColor = .red
        button.setImage(#imageLiteral(resourceName: "btn_menu"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOptionsButton), for: .touchUpInside)
        return button
    }()
    
    //MARK:- menu Labels
    let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.textColor = .white
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = textFont
        return label
    }()
    
    let tvodLabel: UILabel = {
        let label = UILabel()
        label.text = "TVOD"
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.font = textFont
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    let svodLabel: UILabel = {
        let label = UILabel()
        label.text = "SVOD"
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.font = textFont
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    let tvLabel: UILabel = {
        let label = UILabel()
        label.text = "TV    "
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.font = textFont
        label.textColor = .white
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    //MARK:- viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()
        setupScrollView()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)

        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        setupSingleViewContorller()
        setupTVrecommendationController()
        setupSVrecommendationController()
        setupSeeMoreHandler()
        navigationController?.pushViewController(homeController, animated: true)
    }

    // MARK:- setup methods
    
    fileprivate func setupTVODControllerInScrollView() {
        var frame = tvodController.view.frame
        frame.origin.x = 375
        
        tvodController.view.frame = frame
        self.addChild(tvodController)
        scrollView.addSubview(tvodController.view)
    }
    
    fileprivate func setupScrollView() {
        
        let width = homeController.view.bounds.size.width * 3
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .red
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: width, height: 1.0)
        scrollView.isScrollEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.addSubview(homeController.view)
      
        view.addSubview(scrollView)
        scrollView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    
    fileprivate func setupSegmentItems() {
        
        let items = [homeLabel.text, tvodLabel.text, svodLabel.text, tvLabel.text]
        let topSegmentControl = UISegmentedControl(items: items as [Any])
        topSegmentControl.customizeAppearance(for: 20)
        
        topSegmentControl.selectedSegmentIndex = 0
        topSegmentControl.addTarget(self, action: #selector(handleLabelGesture), for: .valueChanged)
        
        view.addSubview(topSegmentControl)
        topSegmentControl.anchor(top: nil, leading: optionsButton.trailingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
    }
    
    fileprivate func setupHeader() {
        
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width, height: 130))
        
        view.addSubview(optionsButton)
        optionsButton.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 50, height: 50))
        setupSegmentItems()
        
        headerView.addSubview(headerlogoImageView)
        headerlogoImageView.centerInSuperview()
        
    }
    
    //MARK:- handle methods
    
    @objc func handleLabelGesture(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.size.width * 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: true)
        case 1:
            setupTVODControllerInScrollView()
            scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.size.width * 1, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: true)
        case 2:
            scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.size.width * 2, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: true)
        case 3:
            self.present(tvChannelController,animated: true)
        default:
            break
        }
    }
    
    var viewFrame: CGRect?
    let blackView = UIView()
    
    @objc func handleOptionsButton() {
        
        self.view.addSubview(blackView)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        blackView.frame = self.view.frame
        
        self.viewFrame = self.view.frame
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: self.menuWidth, y: 0, width: 100, height: self.view.frame.height)
         
        }, completion: nil)
    }
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = self.viewFrame!
            self.blackView.removeFromSuperview()
        }, completion: nil)
    }
    //MARK:- setup closure and singleViewController
    
    fileprivate func setupSeeMoreHandler() {
        
        homeController.tvseemoreHandler = {
            print("fsdf")
            
            self.scrollView.scrollRectToVisible(CGRect(x: self.scrollView.frame.size.width * 1, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height), animated: true)
        }
        
    }
    
    var productIdHandler: ((String) ->())?
    
    fileprivate func setupSingleViewContorller() {
        
        let redView = animatedSingleViewController.view
        
        homeController.presentHandler = { featuredList, indexPath in
            
            if featuredList.type == "UNION" || featuredList.type == "SINGLE"{
                
                let landscapeUrlString = featuredList.posterLandscapeUrl
                let landscapeUrl = URL(string: landscapeUrlString)
                let portraitUrlString = featuredList.posterPortraitUrl
                let portraitUrl = URL(string: portraitUrlString)
                
                self.animatedSingleViewController.landscapeImageView.sd_setImage(with: landscapeUrl, completed: nil)
                self.animatedSingleViewController.portraitImageView.sd_setImage(with: portraitUrl, completed: nil)
                
                self.animatedSingleViewController.productId = featuredList.productId
                self.animatedSingleViewController.type = featuredList.type
                
                self.view.addSubview(redView!)
                
                redView?.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)

                redView?.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 300)

                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .transitionCrossDissolve, animations: {
                    redView?.frame = self.view.frame
                }, completion: nil)
            }
                
            else if featuredList.type == "PACKAGE" {
                self.packageTypeSingleViewController.productId = featuredList.productId
                self.present(self.packageTypeSingleViewController, animated: true)
            }
        }
    }
    
    func setupTVrecommendationController() {
        homeController.tvPresentHandler = { tvRecommend, indexPath in
            
            if tvRecommend.recommendBannerImages[indexPath.item].vod.type == "UNION" || tvRecommend.recommendBannerImages[indexPath.item].vod.type == "SINGLE"
            {
                self.present(self.tvsvSinngleViewController, animated: true)
                
                let landscapeUrlString = tvRecommend.recommendBannerImages[indexPath.item].vod.posterLandscapeUrl
                let landscapeUrl = URL(string: landscapeUrlString)
                
                let portraitUrlString = tvRecommend.recommendBannerImages[indexPath.item].vod.posterPortraitUrl
                let portraitUrl = URL(string: portraitUrlString)
                
                self.tvsvSinngleViewController.landscapeImageView.sd_setImage(with: landscapeUrl, completed: nil)
                self.tvsvSinngleViewController.portraitImageView.sd_setImage(with: portraitUrl, completed: nil)
                
                if tvRecommend.recommendBannerImages[indexPath.item].vod.type == "SINGLE" {
                    self.tvsvSinngleViewController.singleProduct_fetch(productId: tvRecommend.recommendBannerImages[indexPath.item].vod.productId!)
                }
                    
                else {
                    self.tvsvSinngleViewController.unionInfo_fetch(productId: tvRecommend.recommendBannerImages[indexPath.item].vod.productId!)
                }
                
            }
                
            else if tvRecommend.recommendBannerImages[indexPath.item].vod.type == "PACKAGE" {
                self.present(self.packageTypeSingleViewController, animated: true)
            }
        }
    }
    
    func setupSVrecommendationController() {
        homeController.svPresentHandler = { svRecommend, indexPath in
            
            if svRecommend.recommendBannerImages[indexPath.item].vod.type == "UNION" || svRecommend.recommendBannerImages[indexPath.item].vod.type == "SINGLE"
            {
                
                self.present(self.tvsvSinngleViewController, animated: true)
                
                let landscapeUrlString = svRecommend.recommendBannerImages[indexPath.item].vod.posterLandscapeUrl
                let landscapeUrl = URL(string: landscapeUrlString)
                
                let portraitUrlString = svRecommend.recommendBannerImages[indexPath.item].vod.posterPortraitUrl
                let portraitUrl = URL(string: portraitUrlString)
                
                self.tvsvSinngleViewController.landscapeImageView.sd_setImage(with: landscapeUrl, completed: nil)
                self.tvsvSinngleViewController.portraitImageView.sd_setImage(with: portraitUrl, completed: nil)
                
                if svRecommend.recommendBannerImages[indexPath.item].vod.type == "SINGLE" {
                    self.tvsvSinngleViewController.singleProduct_fetch(productId: svRecommend.recommendBannerImages[indexPath.item].vod.productId!)
                }
                    
                else {
                    self.tvsvSinngleViewController.unionInfo_fetch(productId: svRecommend.recommendBannerImages[indexPath.item].vod.productId!)
                }
                
            }
                
            else if svRecommend.recommendBannerImages[indexPath.item].vod.type == "PACKAGE" {
                
                self.packageTypeSingleViewController.productId = svRecommend.recommendBannerImages[indexPath.item].vod.productId!
                
                self.present(self.packageTypeSingleViewController, animated: true)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
