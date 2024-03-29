//
//  APIService.swift
//  APIService_Look
//
//  Created by Mirzoulugbek Yusupov on 7/8/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

var list: Int = 4

class APIService {
    
    static let shared = APIService()
    
    func featuredList_fetch(completion: @escaping ([FeaturedList_Lists], Error?) -> ()) {
        
        let featured_listURL = "https://api.looktv.mn/api/product/featured_list?platformId=2c9f807e51955cea0151a5f6a83200ab"
        
        guard let url = URL(string: featured_listURL) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch dat: ", err)
                completion([],nil)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let rootJSON = try JSONDecoder().decode(FeatureList_RootModel.self, from: data)
                completion(rootJSON.list, nil)
            }
                
            catch let jsonErr {
                print("failed to decode json: ", jsonErr)
                completion([],jsonErr)
            }
            
            }.resume()
    }
    
    func tvRecomendation_fetch(completion: @escaping ([TV_SV_List]?, Error?) -> ()) {
        
        let TVRecommendationUrl = "https://api.looktv.mn/api/product/recommend_banner_list?platformId=2c9f807e51955cea0151a5f6a83200ab&saleType=TVOD"
        
        fetch(urlStirng: TVRecommendationUrl, completion: completion)
    }
    
    func svRecommendation_fetch(completion: @escaping ([TV_SV_List]?, Error?) -> ()) {
        
        let SVRecommendationnURL = "https://api.looktv.mn/api/product/recommend_banner_list?platformId=2c9f807e51955cea0151a5f6a83200ab&saleType=SVOD"
        fetch(urlStirng: SVRecommendationnURL, completion: completion)
        
    }

    func fetch(urlStirng: String, completion: @escaping (([TV_SV_List]?, Error?) -> ())) {
        
        guard let url = URL(string: urlStirng) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch dat: ", err)
                completion(nil,err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let rootJSON = try JSONDecoder().decode(TV_SV_RootModel.self, from: data)
                completion(rootJSON.list, nil)
            }
                
            catch let jsonErr {
                print(jsonErr)
                completion(nil,jsonErr)
            }
            }.resume()
    }
    
    func newsList_fetch(completion: @escaping ([Newslist_List]?, Error?) -> ()) {
        
        let NewsListUrl = "https://api.looktv.mn/api/notice/list?platformId=2c9f807e51955cea0151a5f6a83200ab&pageSize=20&page=1"
        
        guard let url = URL(string: NewsListUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch dat: ", err)
                completion(nil,err)
                return
            }
            
            
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(newsList_RootModel.self, from: data)
                completion(rootJSON.list, nil)
            }
                
            catch let jsonErr {
                print(jsonErr)
                completion(nil,jsonErr)
            }
            }.resume()
    }
}
