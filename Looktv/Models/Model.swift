//
//  Model.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

struct Platform: Decodable {
    let createdDt: CLong
    let updatedDt: CLong
    let updatedBy: String
    let id: String
    let name: String
}

struct FeaturedList_PriceList: Decodable {
    let saleType: String
    var categoryId: String?
    let categoryPrices: [FeaturedList_CategoryPrices]!
    var categoryName: String?
    var categorySubName: String?
    var productPriceId: String?
    var discoundRate: Int?
}

struct FeaturedList_CategoryPrices: Decodable {
    let createdDt: CLong
    let createdBy: String
    let updatedDt: CLong
    let updatedBy: String
    let categoryPriceType: String
    let univisionCategoryId: String
    let categoryPriceId: String
    let price: Int
    let orgPrice: Int
}

struct TV_SV_List: Decodable {
    let createdBy: String?
    let updatedBy: String?
    let bannerType: String?
    let saleType: String?
    let recommendBannerImages: [RecommendBannerImagesModel] // 6 items in each list's reccomendBannerImages
}

struct TV_SV_PriceList: Decodable {
    let createdBy: String
    let updatedBy: String
    let saleType: String
    let priceRental: Int
    let period: Int
    let sortSeq: Int
    let productPriceId: String
    let discountRate: Int
}


struct CategoryIdList: Decodable {
    
}

struct Vod: Decodable {
    let createdDt: CLong
    let type: String
    let name: String
    let titleClassification: String
    let version: String
    let platform: Platform // 5 items in each vod's platform
    let sellChild: Bool
    var watchCount: Int?
    let subName: String
    var rating: String?
    var duration: Int?
    var libraryId: String?
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let watchable: Int
    var formattedDuration: String?
    var genre: String?
    var releaseYear: Int?
    var director: String?
    var actor: String?
    var studio: String?
    var productId: String?
//    let priceList: [TV_SV_PriceList]
    var firstChildFree: Int?
    var description: String?
//    let packageProductIdList: [Void?]
    let categoryIdList: CategoryIdList
    var discountRate: Int?
}

struct RecommendBannerImagesModel: Decodable {
    let vod: Vod // 28 items in each banner's vod
    let bannerImageUrl: String
    let bannerSeq: Int
}


struct FeaturedList_Lists: Decodable {
    let createdDt: Int
    let type: String
    let name: String
    let titleClassification: String
    let version: String
    let platform: Platform
    let sellChild: Bool
    var watchCount: Int?
    let subName: String
    var rating: String?
    var duration: Int?
    var libraryId: String?
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    var watchable: Int?
    let formattedDuration: String?
    var genre: String?
    var releaseYear: Int?
    var director: String?
    var actor: String?
    var studio: String?
    var productId: String?
    let priceList: [FeaturedList_PriceList]
    var firstChildFree: Int?
    var description: String?
//    let packageProductIdList: [Void]
    let categoryIdList: [CategoryIdList]
    var discountRate: Int?
}

struct TV_SV_RootModel: Decodable { // 1 object
    let pageSize: Int
    let fullListSize: Int
    let list: [TV_SV_List] // 4 items in a list
    let page: Int
    let firstRecordIndex: Int
    let resultCode: String
}

struct FeatureList_RootModel: Decodable { // 1 object
    let pageSize: Int
    let fullListSize: Int
    let list: [FeaturedList_Lists] // 4 items in a list
    let page: Int
    let firstRecordIndex: Int
    let resultCode: String
}

struct Newslist_List: Decodable {
    let createdBy: String
    let updatedDt: String
    let updatedBy: String
    let id: String
    let title: String
    let content: String
}

struct Newslist_Search: Decodable {
    let platformId: String
}

struct newsList_RootModel: Decodable {
    let pageSize: Int
    let fullListSize: Int
    let list: [Newslist_List] // 4 items in a list
    let page: Int
    let firstRecordIndex: Int
    let search: Newslist_Search
    let resultCode: String
}

struct Union_Info: Decodable {
    let name: String
    let description: String
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let isFavorite: Int
    let duration: Int?
//    let rating: String
    let genre: String
    let actor: String
    let director: String
    let studio: String
    let releaseYear: Int
    let snapShotUrl: String
    let snapshotCount: Int
    let list: [UnionInfo_List]
    let resultCode: String
}

struct UnionInfo_List: Decodable {
    let createdDt: CLong
    let type: String
    let name: String
    let platform: Platform
    let sellChild: Bool
    let watchCount: Int
    let rating: String
    let duration: Int
    let libraryId: String
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let watchable: Int
    let formattedDuration: String
    let genre: String
    let releaseYear: Int?
    let director: String
    let actor: String
    let studio: String
    let productId: String
    //    let priceList: []
    let firstChildFree: Int
    let description: String
    //    let packageProductIdList: [PackageInfo_PackageProductIdList]
    //    let categoryIdList []
    let discountRate: Int
}

struct Package_Info: Decodable {
    let name: String
    let description: String
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let isFavorite: Int
    let sellChild: Int
    let watchable: Int
    let firstChildFree: Int
    let resultCode: String
    let list: [PackageInfo_List]
    let priceList: [PackageInfo_PriceList]
}

struct PackageInfo_Detail: Decodable {
    let name: String
    let duration: Int
    let genre: String
    let description: String
    let actor: String
    let director: String
    let studio: String
    let releaseYear: Int
    let watchable: Int
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let isFavorite: Int
    let snapShotUrl: String
    let snapshotCount: Int
    let resultCode: String
}

struct PackageInfo_List: Decodable {
    let createdDt: CLong
    let type: String
    let name: String
    let platform: Platform
    let sellChild: Bool
    let watchCount: Int
    let rating: String
    let duration: Int
    let libraryId: String
    let posterPortraitUrl: String
    let posterLandscapeUrl: String
    let watchable: Int
    let formattedDuration: String
    let genre: String
    let releaseYear: Int
    let director: String
    let actor: String
    let studio: String
    let productId: String
//    let priceList: []
    let firstChildFree: Int
    let description: String
//    let packageProductIdList: [PackageInfo_PackageProductIdList]
//    let categoryIdList []
    let discountRate: Int
}

struct PackageInfo_PriceList: Decodable {
    let saleType: String
    let categoryId: String
    let categoryPrices: [PackageInfo_CategoryPrices]
    let categoryName: String
    let categorySubName: String
    let productPriceId: String
    let discountRate: Int
}

struct PackageInfo_CategoryPrices: Decodable {
    let createdDt: CLong
    let createdBy: String
    let updatedDt: CLong
    let updatedBy: String
    let categoryPriceType: String
    let univisionCategoryId: String
    let categoryPriceId: String
    let price: Int
    let orgPrice: Int
}

struct Video: Decodable {
    let codec: String?
    let streamList: [StreamList]
    let trailerList: [TrailerList]
//    let previewList: []
//    let downloadList: []
//    let subtitleList: []
    let encryption: Bool
    let assetId: String
    let resultCode: String
}

struct StreamList: Decodable {
    let type: String
    let url: String
//    let streamList: []
}

struct TrailerList: Decodable {
    let type: String
    let url: String
//    let streamList: []
}
//struct PackageInfo_PackageProductIdList: Decodable {
//
//}
