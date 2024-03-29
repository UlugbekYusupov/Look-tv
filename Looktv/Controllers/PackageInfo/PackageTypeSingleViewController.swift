//
//  PackageTypeSingleViewController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/19/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class PackageTypeSingleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- instance vars
    var productId: String?
    
    let singleController = tvsvSingleViewController()
    private let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        tv.delegate = self
        tv.dataSource = self
        tv.register(PackageCell.self, forCellReuseIdentifier: self.cellId)
        return tv
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5340566039, green: 0.538184762, blue: 0.572317183, alpha: 1)
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 15)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 12)
        label.numberOfLines = 10
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "icon_category_open"), for: .normal)
        return button
    }()
   
    let name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        return label
    }()
    
    
    //MARK:- tableView override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageInfoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PackageCell
        cell.nameLabel.text = packageInfoList[indexPath.item].name
        let duration = packageInfoList[indexPath.item].duration
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        let formattedString = formatter.string(from: TimeInterval(duration))!
        
        cell.formattedDurationLabel.text = formattedString + " |"
        cell.releaseYearLabel.text = "\(packageInfoList[indexPath.item].releaseYear)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(singleController, animated: true)
        singleController.type = packageInfoList[indexPath.row].type
        singleController.detailFetch(productId: packageInfoList[indexPath.row].productId)
    }
    
    
    //MARK:- setup methods
    fileprivate func setupHeader() {
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)

        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        topView.layer.insertSublayer(gradient, at: 0)
        
        view.addSubview(topView)
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        topView.addSubview(dismissButton)
        dismissButton.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 10, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        topView.addSubview(name)
        name.centerXInSuperview()
        name.anchor(top: nil, leading: nil, bottom: topView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
        view.addSubview(headerView)
        headerView.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 250))
        
        headerView.addSubview(imageView)
        imageView.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 15, bottom: 0, right: 0), size: CGSize(width: 130, height: 200))
        
        headerView.addSubview(nameLabel)
        nameLabel.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        headerView.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 10), size: CGSize(width: 0, height: 0))
    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        setupHeader()
        
        view.addSubview(bottomLine)
        bottomLine.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        view.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        tableView.separatorStyle = .none

        print(productId!)
        packageInfo_fetch(productId: productId!)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK:- API service
    var packageInfoList = [PackageInfo_List]()
    var packageInfo: Package_Info? {
        didSet {
            DispatchQueue.main.async {
                self.name.text = self.packageInfo?.name
                self.nameLabel.text = self.packageInfo?.name
                self.descriptionLabel.text = self.packageInfo?.description
                self.imageView.sd_setImage(with: URL(string: self.packageInfo!.posterPortraitUrl), completed: nil)
            }
        }
    }
    func packageInfo_fetch(productId: String) {
        
        let unionInfoUrl = "https://api.looktv.mn/api/product/package_info?productId=\(productId)"
        guard let url = URL(string: unionInfoUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(Package_Info.self, from: data)
                self.packageInfoList = rootJSON.list
                self.packageInfo = rootJSON
            }
            catch let jsonErr {
                print(jsonErr)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            }.resume()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK:- handle methods
    
    @objc func handleDismiss() {
        self.removeFromParent()
        self.dismiss(animated: true, completion: nil)
    }
    
}
