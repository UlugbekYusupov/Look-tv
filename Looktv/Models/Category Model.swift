//
//  Category Model.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/6/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

struct Category: Decodable {
    let pageSize: Int
    let fullListSize: Int
    let list: [Category_List]
    let page: Int
    let firstRecordIndex: Int
    let resultCode: String
}

struct Category_List: Decodable {
    let createdDt: CLong
    let updatedDt: CLong
    let updatedBy: String
    let id: String
    let name: String
    let subName: String
    let children: [Category_Children]
//    let categoryPrices: []
    let deleted: Bool
    let categoryNameWithParentName: String
    let sale_type: String
//    let subscriptionPrices
}

struct Category_Children: Decodable {
    let createdDt: CLong
    let updatedDt: CLong
    let updatedBy: String
    let id: String
    let name: String
    let subName: String
    let children: [Category_Children_Children]
    //    let categoryPrices: []
    let deleted: Bool
    let parentCategoryId: String
    let categoryNameWithParentName: String
    let sale_type: String
    //    let subscriptionPrices
}

struct Category_Children_Children: Decodable {
    let createdDt: CLong
    let updatedDt: CLong
    let updatedBy: String
    let id: String
    let name: String
    let subName: String
    let children: [Category_Children_Children_Children]
    //    let categoryPrices: []
    let deleted: Bool
    let parentCategoryId: String
    let categoryNameWithParentName: String
    let sale_type: String
    //    let subscriptionPrices
}

struct Category_Children_Children_Children: Decodable {
    let createdDt: CLong
    let updatedDt: CLong
//    let updatedBy: String
    let id: String
    let name: String
    let subName: String
    let children: [Category_Children_Children_Children]
    //    let categoryPrices: []
    let deleted: Bool
    let parentCategoryId: String
    let categoryNameWithParentName: String
    let sale_type: String
    //    let subscriptionPrices
}
