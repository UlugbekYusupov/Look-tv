//
//  TVODController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/15/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class TVODController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = categoryList?.children[0].children.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TVODCell
        
        cell.sectionNameLabel.text = categoryList.children[0].children[indexPath.section].name
        
        cell.fetchProductList(productId: categoryList.children[0].children[indexPath.section].id)
        
//        print(categoryList.children[0].children[indexPath.section].id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    let headerView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        return v
    }()
    
    let cellID = "cellID"
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.1296256483, green: 0.1348594427, blue: 0.1602581739, alpha: 1)
//        tv.backgroundColor = .yellow
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.register(TVODCell.self, forCellReuseIdentifier: self.cellID)
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1296256483, green: 0.1348594427, blue: 0.1602581739, alpha: 1)
        
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 40))
        
        view.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 480))
        fetchCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var categoryList: Category_List!
    
     func fetchCategory() {
        let categoryUrl = "https://api.looktv.mn/api/category/list?categoryId=2c9f807e51955cea0151a602ff1400ae&platformId=2c9f807e51955cea0151a5f6a83200ab"
        
        guard let url = URL(string: categoryUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(Category.self, from: data)
                rootJSON.list.forEach({ (list) in
                    self.categoryList = list
                })
            }
            catch let jsonErr {
                print(jsonErr)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            }.resume()
    }
}
