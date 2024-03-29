//
//  tvRecomendationController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/4/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class tvRecomendationController: UICollectionViewController,UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable {
    
    let cellID = "cellID"
   
    //MARK:- viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(tvActualCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false

        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        tvFetch()
    }
    
    //MARK:- collectionView override methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvRecommendation.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! tvActualCell
        
        let i = indexPath.row
        
        if tvRecommendation[i].bannerType == "A" {
            let view = ViewA()
            cell.view.addSubview(view)
            view.anchor(top: cell.view.topAnchor, leading: cell.view.leadingAnchor, bottom: cell.view.bottomAnchor, trailing: cell.view.trailingAnchor)

            for j in tvRecommendation[i].recommendBannerImages.count {
                let url = URL(string: tvRecommendation[i].recommendBannerImages[j].bannerImageUrl)
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
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            return cell
        }

        else if tvRecommendation[i].bannerType == "B" {
            let view = ViewB()
            cell.view.addSubview(view)
            view.anchor(top: cell.view.topAnchor, leading: cell.view.leadingAnchor, bottom: cell.view.bottomAnchor, trailing: cell.view.trailingAnchor)

            for j in tvRecommendation[i].recommendBannerImages.count {
                let url = URL(string: tvRecommendation[i].recommendBannerImages[j].bannerImageUrl)
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
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            return cell
        }

        else if tvRecommendation[i].bannerType == "C" {
            let view = ViewC()
            cell.view.addSubview(view)
            view.anchor(top: cell.view.topAnchor, leading: cell.view.leadingAnchor, bottom: cell.view.bottomAnchor, trailing: cell.view.trailingAnchor)

            for j in tvRecommendation[i].recommendBannerImages.count {
                let url = URL(string: tvRecommendation[i].recommendBannerImages[j].bannerImageUrl)
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
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            return cell
            }
        }
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width + 230, height: view.frame.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 15, bottom: 0, right: 15)
    }

    var didSelectHandler: ((TV_SV_List, IndexPath)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvRecommendation = self.tvRecommendation[indexPath.item]
        didSelectHandler?(tvRecommendation, indexPath)
    }
    
    //MARK: API fetch
    var tvRecommendation = [TV_SV_List]()
    
    func tvFetch() {
        APIService.shared.tvRecomendation_fetch { (list, err) in
            if let err = err {
                print("Failed to fetch: ", err)
            }
            guard let list = list else {return}
            self.tvRecommendation = list
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
