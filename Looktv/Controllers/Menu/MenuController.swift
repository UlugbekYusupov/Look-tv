//
//  MenuController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/12/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuLabelTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MenuCell
        cell.menuLabel.text = menuLabelTexts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

class MenuController: UIViewController, UISearchBarDelegate {
   
    var menuLabelTexts = ["Home", "Gift Card", "Coupan", "My Download", "Purchased List", "History", "Setting / Toxipgo", "Support"]
    
    var userStatus: Bool = false
    var subsciptionStatus: Bool = false
    
    let rootController = RootController()
    
    static let shared = MenuController()
    
    let cellID = "c"
    lazy var menuTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        tv.register(MenuCell.self, forCellReuseIdentifier: self.cellID)
        return tv
    }()
    
    let pleaseLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        button.addTarget(self, action: #selector(handlePleaseLogin), for: .touchUpInside)
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        return button
    }()
    
    let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "LOG OUT"
        label.textColor = .white
        label.clipsToBounds = true
//        label.backgroundColor = .red
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.font = UIFont(name:"Myanmar Sangam MN", size: 10)
        return label
    }()
   
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.barTintColor = .clear
        bar.backgroundImage = UIImage()
        bar.placeholder = "Search"
        return bar
    }()
    
    let userInfoView = UIView()
    let headerView = UIView()
    let subscriptionInfoView = UIView()
    
    fileprivate let menuWidth: CGFloat = 280
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        
        setuoHeaderView()
        
        switch userStatus {
        case true:
            ifLoggedIn()
        case false:
            ifLoggedOut()
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.menuTableView.reloadData()
        }
    }
    
    fileprivate func setuoHeaderView() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 90))
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(x: 0, y: 0, width: view.frame.width, height: 90.0)
        
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        headerView.addSubview(searchBar)
        searchBar.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 13, bottom: 10, right: 0), size: CGSize(width: 250, height: 40))
       
        for subview in searchBar.subviews {
            if subview.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                subview.removeFromSuperview()
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    
    fileprivate func ifLoggedIn() {
        view.addSubview(userInfoView)
        userInfoView.anchor(top: headerView.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 90))
        userInfoView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        
        menuLabelTexts.append("Notifications")
        self.menuTableView.reloadData()
        
        userInfoView.addSubview(userImageView)
        userImageView.anchor(top: userInfoView.topAnchor, leading: userInfoView.leadingAnchor, bottom: userInfoView.bottomAnchor, trailing: nil, padding: .init(top: 18, left: 15, bottom: 18, right: 0), size: CGSize(width: 55, height: 0))
        
        userInfoView.addSubview(emailIDLabel)
        emailIDLabel.anchor(top: userImageView.topAnchor, leading: userImageView.trailingAnchor, bottom: userImageView.bottomAnchor, trailing: nil, padding: .init(top: 20, left: 10, bottom: 20, right: 0), size: CGSize(width: 145, height: 0))
        
        userInfoView.addSubview(logoutButton)
        logoutButton.anchor(top: userImageView.topAnchor, leading: nil, bottom: userImageView.bottomAnchor, trailing: userInfoView.trailingAnchor, padding: .init(top: 18, left: 0, bottom: 18, right: 10), size: CGSize(width: 50, height: 30))
        logoutButton.addSubview(buttonLabel)
        buttonLabel.centerInSuperview()
        
        if subsciptionStatus {
            view.addSubview(subscriptionInfoView)
            subscriptionInfoView.anchor(top: userInfoView.bottomAnchor, leading: userInfoView.leadingAnchor, bottom: nil, trailing: userInfoView.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 60))
            subscriptionInfoView.backgroundColor = .yellow
            
            view.addSubview(menuTableView)
            menuTableView.anchor(top: subscriptionInfoView.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0 ), size: CGSize(width: 0, height: 240))
        }
        else {
            view.addSubview(menuTableView)
            menuTableView.anchor(top: userImageView.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 18, left: 0, bottom: 0, right: 0 ), size: CGSize(width: 0, height: 240))
        }
    }
    
    fileprivate func ifLoggedOut() {
        
        view.addSubview(pleaseLoginButton)
        pleaseLoginButton.anchor(top: headerView.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 80, bottom: 0, right: 0), size: CGSize(width: 120, height: 30))
        
        view.addSubview(menuTableView)
        menuTableView.anchor(top: pleaseLoginButton.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0 ), size: CGSize(width: 0, height: 240))
    }
    
    //MARK:- handle methods
    
    @objc func handlePleaseLogin() {
        let loginController = LoginController()
        present(loginController, animated: true)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
    }
    
    @objc func delayedAction() {
        self.rootController.blackView.removeFromSuperview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addSubview(rootController.view)
        rootController.view.frame = self.view.frame
    }
}
