//
//  Facebook.swift
//  Looktv
//
//  Created by Mirzoulugbek Yusupov on 8/20/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

struct Facebook: Decodable {
    let resultCode: String
    let message: String
    let token: String
    let userName: String
    let accessTimezone: String
    let accessAccount: String
    let accessNickname: String
    let imageUrl: String
    let userId: String
    let subscriptionList: [SubscriptionList_List]
    let subId: String
    let ger: Int
    let mobileVerified: Int
    let freeProducts: [FreeProducts]
    let mobileVerifiedType: String
    let downloadFeature: DownLoadFeature
}

struct SubscriptionList_List: Decodable {
    let purchaseType: String
    let id: String
    let name: String
    let buyDt: CLong
    let expireDt: CLong
}

struct FreeProducts: Decodable {
    let freeVodPriceIdList: [String]
    let freeCategoryPackagePriceIdList: [String]
    let freeChannelPackagePriceIdList: [String]
    let freeTvodCategoryIdList: [String]
}

struct DownLoadFeature: Decodable {
    let downloadCountPerDevice: Int
    let deletionDays: Int
    let availableDays: Int
    let expirationDays: Int
    let enabled: Bool
    
}
