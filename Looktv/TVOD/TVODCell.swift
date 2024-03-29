//
//  TVODCell.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/6/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class TVODCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var productId: String!
    var count: Int = 0
    var collectionView: UICollectionView!

    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Section"
        label.clipsToBounds = true
        label.textColor = .white
        label.contentMode = .scaleAspectFill
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! SingleImageViewCell
        
        cell.categoryImageView.sd_setImage(with: URL(string: productList[indexPath.row].posterPortraitUrl), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let tvController = tvsvSingleViewController()
//        if productList[indexPath.row].type == "UNION" {
//            tvController.unionInfo_fetch(productId: productList[indexPath.row].productId)
//        }
//            
//        else if productList[indexPath.row].type == "SINGLE" {
//            tvController.singleProduct_fetch(productId: productList[indexPath.row].productId)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.frame.height + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.1296256483, green: 0.1348594427, blue: 0.1602581739, alpha: 1)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.1296256483, green: 0.1348594427, blue: 0.1602581739, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SingleImageViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(sectionNameLabel)
        sectionNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: CGSize(width: 300, height: 50))
        
        addSubview(collectionView)
        collectionView.anchor(top: sectionNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var productList = [ProductList_List]()
    
    func fetchProductList(productId: String) {
        
        let utlString = "https://api.looktv.mn/api/product/list?platformId=2c9f807e51955cea0151a5f6a83200ab&categoryId=\(productId)"
        
        guard let url = URL(string: utlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(ProductList.self, from: data)
                self.count = rootJSON.list.count
                self.productList = rootJSON.list
            }
                
            catch let jsonErr {
                print(jsonErr)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            }.resume()
      
    }
}
