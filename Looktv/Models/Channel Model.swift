//
//  Channel Model.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/5/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

struct TvListByPackage: Decodable {
    let resultCode: String
    let channelPackageList: [ChannelPackageList_list]
    let channelList: [ChannelList_list]
}

struct ChannelPackageList_list: Decodable {
    let createdDt: CLong
    let createdBy: String?
    let updatedDt: CLong
    let updatedBy: String
    let id: String
    let name: String
    let sortSeq: Int
    //    let discountRate: Int?
    let channelList: [ChannelList_list]
    //    let channelPackagePriceList: [ChannelPackagePriceList]
}

struct ChannelList_list: Decodable {
    let id: String
    let name: String
    let type: String
    let free: Int
    //    let channelPrices: []
    let imageUrl: String
    let number: Int
    let ip: String
}

struct ChannelPackagePriceList: Decodable {
    let createdBy: String
    let updatedBy: String
    let priceType: String
    let univisionChannelPackageId: String
    let channelPackagePriceId: String
    let price: Int
    let orgPrice: Int
}


struct ByPassList: Decodable {
    var requestedChannelNumber: Int?
    var channelId: String?
    var requestDate: String?
    let currentDt: String
    var list: [ByPassList_List]
    let resultCode: String
}

struct ByPassList_List: Decodable {
    let channelId: String
    let channelName: String
    let channelType: String
    let channelNumber: Int
    let schedules: [ByPass_SchedulesList]
}

struct ByPass_SchedulesList: Decodable {
    let scheduleId: String
    let scheduleTime: String
    let duration: Int
    let url: String
    let editable: Bool
    let name: String
    let startDt: String
}

//struct ByPassArray: Decodable {
//    let day: [ByPassList]
//}



var byPassArray = [ByPassList]()


var bypassDictionary = [String:[ByPassList]]() as Dictionary


//var ByPass2Array = [[(String, ByPassList)]]()

