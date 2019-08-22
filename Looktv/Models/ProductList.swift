//
//  ProductList.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/16/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

struct ProductList: Decodable {
    let pageSize: Int
    let fullListSize: Int
    let list: [ProductList_List]
    let page: Int
    let firstRecordIndex: Int
//    let productIds: []
    let resultCode: String
}

struct ProductList_List: Decodable {
    let createdDt: CLong
    let type: String
    let name: String
    let titleClassification: String
    let version: String
    let platform: Platform
    let sellChild: Bool
    let subName: String
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let watchable: Int
    let productId: String
    //    let priceList: []
    let firstChildFree: Int
    let description: String
    //    let packageProductIdList: [PackageInfo_PackageProductIdList]
    //    let categoryIdList []
    let discountRate: Int
}