//
//  svRecomendationController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

class svRecomendationController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    let cellID = "cellID"
    
    //MARK:- viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        collectionView.register(svActualCell.self, forCellWithReuseIdentifier: cellID)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.showsHorizontalScrollIndicator = false
        svFetch()
    }
    
    //MARK:- collectionView override methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return svRecommendation.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! svActualCell
        
        let i = indexPath.row
        if svRecommendation[i].bannerType == "A" {
                let view = ViewA()
                for j in svRecommendation[i].recommendBannerImages.count {
                    let url = URL(string: svRecommendation[i].recommendBannerImages[j].bannerImageUrl)
                    switch j {
                    case 0:
                        view.firstImageView.sd_setImage(with: url, completed: nil)
                    case 1:
                        view.secondImageView.sd_setImage(with: url, completed: nil)
                    case 2:
                        view.thirdImageView.sd_setImage(with: url, completed: nil)
                    case 3:
                        view.fourthImageView.sd_setImage(with: url, completed: nil)
                    case 4:
                        view.fifthImageView.sd_setImage(with: url, completed: nil)
                    case 5:
                        view.sixthImageView.sd_setImage(with: url, completed: nil)
                    default:
                        break
                    }
                }
                cell.view.addSubview(view)
                view.anchor(top: cell.view.topAnchor, leading: cell.view.leadingAnchor, bottom: cell.view.bottomAnchor, trailing: cell.view.trailingAnchor)
                return cell
            }
            
            else if svRecommendation[i].bannerType == "B" {
                let view = ViewB()
                for j in svRecommendation[i].recommendBannerImages.count {
                    let url = URL(string: svRecommendation[i].recommendBannerImages[j].bannerImageUrl)
                    switch j {
                    case 0:
                        view.firstImageView.sd_setImage(with: url, completed: nil)
                    case 1:
                        view.secondImageView.sd_setImage(with: url, completed: nil)
                    case 2:
                        view.thirdImageView.sd_setImage(with: url, completed: nil)
                    case 3:
                        view.fourthImageView.sd_setImage(with: url, completed: nil)
                    case 4:
                        view.fifthImageView.sd_setImage(with: url, completed: nil)
                    case 5:
                        view.sixthImageView.sd_setImage(with: url, completed: nil)
                    default:
                        break
                    }
                }
                cell.view.addSubview(view)
                view.anchor(top: cell.view.topAnchor, leading: cell.view.leadingAnchor, bottom: cell.view.bottomAnchor, trailing: cell.view.trailingAnchor)
                return cell
            }
            
            else if svRecommendation[i].bannerType == "C" {
                let view = ViewC()
                for j in svRecommendation[i].recommendBannerImages.count {
                    let url = URL(string: svRecommendation[i].recommendBannerImages[j].bannerImageUrl)
                    switch j {
                    case 0:
                        view.firstImageView.sd_setImage(with: url, completed: nil)
                    case 1:
                        view.secondImageView.sd_setImage(with: url, completed: nil)
                    case 2:
                        view.thirdImageView.sd_setImage(with: url, completed: nil)
                    case 3:
                        view.fourthImageView.sd_setImage(with: url, completed: nil)
                    case 4:
                        view.fifthImageView.sd_setImage(with: url, completed: nil)
                    case 5:
                        view.sixthImageView.sd_setImage(with: url, completed: nil)
                    default:
                        break
                    }
                }
                cell.view.addSubview(view)
                view.anchor(top: cell.view.topAnchor, leading: cell.view.leadingAnchor, bottom: cell.view.bottomAnchor, trailing: cell.view.trailingAnchor)
                return cell
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width + 230, height: view.frame.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    var didSelectHandler: ((TV_SV_List, IndexPath)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let svRecommendation = self.svRecommendation[indexPath.item]
        didSelectHandler?(svRecommendation, indexPath)
    }
    
    //MARK:- API fetch
    
    var svRecommendation = [TV_SV_List]()
    
    func svFetch() {
        APIService.shared.svRecommendation_fetch { (list, err) in
            if let err = err {
                print("Failed to fetch: ", err)
            }
            guard let list = list else {return}
            self.svRecommendation = list
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
