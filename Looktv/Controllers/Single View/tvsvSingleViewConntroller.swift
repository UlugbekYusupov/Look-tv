//
//  tvsvSingleViewConntroller.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/24/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

var count1: Int = 0

class tvsvSingleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let videoController = PlayerViewController()
    
    var type: String?
    
    static let shared = tvsvSingleViewController()
    
    let selectedTransparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let videoPlayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "player_icon"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count1
    }
    
    var snapShotHandler: ((SingleSnapshotCell, IndexPath)->())?
    var singleSelectImageHandler: ((SingleSnapshotCell, IndexPath) -> ())?

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! SingleSnapshotCell
        
        snapShotHandler?(cell, indexPath)
        
        if type != "SINGLE" {
            if indexPath.row == 0 {
                cell.addSubview(selectedTransparentView)
                selectedTransparentView.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: cell.trailingAnchor)
                selectedTransparentView.backgroundColor = .clear
                selectedTransparentView.layer.borderColor = #colorLiteral(red: 0, green: 0.8994353414, blue: 0.7261761427, alpha: 1).cgColor
                selectedTransparentView.layer.borderWidth = 2
                selectedTransparentView.layer.cornerRadius = 3
                
                cell.addSubview(videoPlayButton)
                videoPlayButton.centerXInSuperview()
                videoPlayButton.centerYInSuperview()
                videoPlayButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(), size: CGSize(width: 40, height: 40))
                videoPlayButton.addTarget(self, action: #selector(handleVideo), for: .touchUpInside)
                videoPlayButton.layer.cornerRadius = 40 / 2
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SingleSnapshotCell
        
        cell.addSubview(selectedTransparentView)
        selectedTransparentView.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: cell.trailingAnchor)
        selectedTransparentView.backgroundColor = .clear
        selectedTransparentView.layer.borderColor = #colorLiteral(red: 0, green: 0.8994353414, blue: 0.7261761427, alpha: 1).cgColor
        selectedTransparentView.layer.borderWidth = 2
        selectedTransparentView.layer.cornerRadius = 3
        
        singleSelectImageHandler?(cell, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    @objc func handleVideo() {
        self.present(videoController, animated: true)
    }
    
    //MARK:-Labels
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        scroll.showsVerticalScrollIndicator = false
        scroll.isScrollEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let runTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let releasedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 10
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let storyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 8
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    //MARK:- round image view
    let genreRound: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "header_round").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let directorRound: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "header_round").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let runtimeRound: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "header_round").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let releasedRound: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "header_round").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let actorRound: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "header_round").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let storyRound: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "header_round").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    //MARK:- Hard code labels, immutable
    let genre: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 9)
        return label
    }()
    
    let director: UILabel = {
        let label = UILabel()
        label.text = "Director"
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 9)
        return label
    }()
    
    let runTime: UILabel = {
        let label = UILabel()
        label.text = "Runtime"
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 9)
        return label
    }()
    
    let released: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 9)
        return label
    }()
    
    let actor: UILabel = {
        let label = UILabel()
        label.text = "Actor"
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 9)
        return label
    }()
    
    let story: UILabel = {
        let label = UILabel()
        label.text = "Story"
        label.textColor = .lightGray
        label.font = UIFont(name: "Verdana", size: 9)
        return label
    }()
    
    //MARK:- play and download button
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)

        return button
    }()
    
    let playImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "btn_play_icon")
        image.clipsToBounds = true
        return image
    }()
    let downloadImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "btn_download_icon")
        image.clipsToBounds = true
        return image
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDownload), for: .touchUpInside)
        return button
    }()
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "DOWNLOAD"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    let playLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "PLAY"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "icon_category_open"), for: .normal)
        return button
    }()
    
    //MARK:- portrait and landscape imageVIew
    let portraitImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let landscapeImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "Images"
        label.font = UIFont(name: "Verdana", size: 16)
        label.textColor = .white
        label.clipsToBounds = true
        label.contentMode = .left
        return label
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        return label
    }()
    
    let snapshotImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        
        view.backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        setupImages()
        setupBottomLabels()
        setupLabelsAndButtons()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        
        headerView.addSubview(name)
        name.centerXInSuperview()
        name.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
        let gradient = CAGradientLayer()
        gradient.frame = headerView.bounds
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: headerView.bottomAnchor, leading: headerView.leadingAnchor, bottom: view.bottomAnchor, trailing: headerView.trailingAnchor)
        
        let height = view.bounds.height
        scrollView.contentSize = CGSize(width: view.bounds.width, height: height + 250)
        scrollView.delegate = self
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        
        scrollView.addSubview(topView)
        topView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width, height: 500))
        
        
        scrollView.addSubview(bottomView)
        bottomView.anchor(top: topView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 500))
        
        bottomView.addSubview(snapshotImageView)
        snapshotImageView.anchor(top: collectionView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 250))
        topView.roundCorners([.bottomLeft, .bottomRight], radius: 30)
        
        view.addSubview(imageLabel)
        imageLabel.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 15, right: 0), size: CGSize(width: 100, height: 0))
    }
    
    //MARK:- setup methods
    fileprivate func setupLabelsAndButtons() {
        
        let roundStackView = UIStackView(arrangedSubviews: [genreRound,directorRound,runtimeRound,releasedRound])
        topView.addSubview(roundStackView)
        roundStackView.anchor(top: landscapeImageView.bottomAnchor, leading: portraitImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 8, bottom: 0, right: 0), size: CGSize(width: 5, height: 0))
        roundStackView.distribution = .equalSpacing
        roundStackView.spacing = 13
        roundStackView.axis = .vertical
        
        
        let labelStackView = UIStackView(arrangedSubviews: [genre, director, runTime, released])
        topView.addSubview(labelStackView)
        labelStackView.anchor(top: landscapeImageView.bottomAnchor, leading: roundStackView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0), size: CGSize(width: 50, height: 0))
        labelStackView.distribution = .equalSpacing
        labelStackView.spacing = 8
        labelStackView.axis = .vertical
        
        
        let jsonLabelStackView = UIStackView(arrangedSubviews: [genreLabel, directorLabel, runTimeLabel, releasedLabel])
        topView.addSubview(jsonLabelStackView)
        
        jsonLabelStackView.anchor(top: landscapeImageView.bottomAnchor, leading: nil, bottom: nil, trailing: topView.trailingAnchor, padding: .init(top: 9, left: 0, bottom: 0, right: 0), size: CGSize(width: 150, height: 0))
        
        jsonLabelStackView.distribution = .equalSpacing
        jsonLabelStackView.spacing = 6
        jsonLabelStackView.axis = .vertical
        
        setupViews()
        headerView.addSubview(dismissButton)
        dismissButton.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 10, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
    }
    
    @objc func handleDismiss() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        topView.addSubview(downloadButton)
        downloadButton.anchor(top: nil, leading: portraitImageView.trailingAnchor, bottom: portraitImageView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: CGSize(width: 85, height: 25))
        downloadButton.layer.cornerRadius = 2
        
        topView.addSubview(playButton)
        playButton.anchor(top: nil, leading: nil, bottom: downloadButton.bottomAnchor, trailing: topView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: CGSize(width: 85, height: 25))
        playButton.layer.cornerRadius = 2
        
        downloadButton.addSubview(downloadImage)
        downloadImage.anchor(top: downloadButton.topAnchor, leading: downloadButton.leadingAnchor, bottom: downloadButton.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        
        playButton.addSubview(playImage)
        playImage.anchor(top: playButton.topAnchor, leading: playButton.leadingAnchor, bottom: playButton.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        
        playButton.addSubview(playLabel)
        playLabel.anchor(top: playButton.topAnchor, leading: playImage.trailingAnchor, bottom: playButton.bottomAnchor, trailing: playButton.trailingAnchor, padding: .init(top: 5, left: 8, bottom: 5, right: 0))
        
        downloadButton.addSubview(downloadLabel)
        downloadLabel.anchor(top: downloadButton.topAnchor, leading: downloadImage.trailingAnchor, bottom: downloadButton.bottomAnchor, trailing: downloadButton.trailingAnchor, padding: .init(top: 6, left: 3, bottom: 5, right: 0))
    }
    
    fileprivate func setupBottomLabels() {
        
        let roundStackView = UIStackView(arrangedSubviews: [actorRound,storyRound])
        topView.addSubview(roundStackView)
        roundStackView.anchor(top: portraitImageView.bottomAnchor, leading: topView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 10, bottom: 0, right: 0), size: CGSize(width: 5, height: 0))
        roundStackView.distribution = .equalSpacing
        roundStackView.spacing = 20 // needs channging into autoresizing according the number of line of sentences
        roundStackView.axis = .vertical
        
        
        let labelStackView = UIStackView(arrangedSubviews: [actor,story])
        topView.addSubview(labelStackView)
        labelStackView.anchor(top: portraitImageView.bottomAnchor, leading: roundStackView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 7, bottom: 0, right: 0), size: CGSize(width: 50, height: 0))
        labelStackView.distribution = .equalSpacing
        labelStackView.spacing = 15 // needs channging into autoresizing according the number of line of sentences
        labelStackView.axis = .vertical
        
        
        let jsonLabelStackView = UIStackView(arrangedSubviews: [actorLabel, storyLabel])
        topView.addSubview(jsonLabelStackView)
        
        jsonLabelStackView.anchor(top: portraitImageView.bottomAnchor, leading: labelStackView.trailingAnchor, bottom: nil, trailing: topView.trailingAnchor, padding: .init(top: 9, left: 0, bottom: 0, right: 0), size: CGSize(width: 150, height: 0))
        
        jsonLabelStackView.distribution = .equalSpacing
        jsonLabelStackView.spacing = 1
        jsonLabelStackView.axis = .vertical
    }
    
    
    fileprivate func setViewSettingWithBgShade(view: UIView) {
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: -0.5, height: view.frame.height)
        view.layer.shadowRadius = 2.0
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.masksToBounds = false
    }
    
    fileprivate func setupImages() {
        self.setViewSettingWithBgShade(view: portraitImageView)
        topView.addSubview(landscapeImageView)
        landscapeImageView.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: nil, trailing: topView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 200))
        
        topView.addSubview(portraitImageView)
        portraitImageView.anchor(top: landscapeImageView.topAnchor, leading: landscapeImageView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 120, left: 10, bottom: 0, right: 0), size: CGSize(width: 140, height: 220))
    }
    
    var collectionView: UICollectionView!
    
    fileprivate func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 100), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SingleSnapshotCell.self, forCellWithReuseIdentifier: "cellID")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1)
        self.bottomView.addSubview(collectionView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK:- API fetch
    
    
    
    var detailInfo: PackageInfo_Detail? {
        didSet {
            DispatchQueue.main.async {
                if let runtime = self.detailInfo?.duration {
                    let formatter = DateComponentsFormatter()
                    formatter.allowedUnits = [.hour, .minute]
                    formatter.unitsStyle = .short
                    let formattedString = formatter.string(from: TimeInterval(runtime))!
                    self.runTimeLabel.text = formattedString
                }
                
                if let releaseyear = self.detailInfo?.releaseYear {
                    self.releasedLabel.text = "\(releaseyear)"
                }
                
                self.snapShotHandler = {cell, indexPath in
                    
                    if var string = self.detailInfo?.snapShotUrl {
                        string.insert(contentsOf: "_\(indexPath.row + 1)", at: string.index(string.endIndex, offsetBy: -4))
                        print(string)
                        
                        let urlString = URL(string: string)
                        cell.imageView.sd_setImage(with: urlString, completed: nil)
                        
                        if indexPath.row == 0 {
                            self.snapshotImageView.sd_setImage(with: urlString, completed: nil)
                        }
                    }
                }
                
                let landScapeUrl = URL(string: self.detailInfo!.posterLandscapeUrl)
                self.landscapeImageView.sd_setImage(with: landScapeUrl, completed: nil)
                
                let portraitUrl = URL(string: self.detailInfo!.posterPortraitUrl)
                self.portraitImageView.sd_setImage(with: portraitUrl, completed: nil)
                
                
                self.singleSelectImageHandler = {cell, indexPath in
                    
                    var string = self.detailInfo!.snapShotUrl
                    string.insert(contentsOf: "_\(indexPath.row + 1)", at: string.index(string.endIndex, offsetBy: -4))
                    
                    self.snapshotImageView.sd_setImage(with: URL(string: string), completed: nil)
                }
                
                self.name.text = self.detailInfo?.name
                self.genreLabel.text = self.detailInfo?.genre
                self.directorLabel.text = self.detailInfo?.director
                self.actorLabel.text = self.detailInfo?.actor
                self.storyLabel.text = self.detailInfo?.description
                self.collectionView.reloadData()
            }
        }
    }
    
    func detailFetch(productId: String) {
        let detailUrl = "https://api.looktv.mn/api/product/detail?productId=\(productId)"
        guard let url = URL(string: detailUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(PackageInfo_Detail.self, from: data)
                self.detailInfo = rootJSON
                count1 = self.detailInfo!.snapshotCount

            }
            catch let jsonErr {
                print(jsonErr)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            }.resume()
    }
    
    var unionInfo: Union_Info? {
        didSet {
            DispatchQueue.main.async {
                if let runtime = self.unionInfo?.duration {
                    let formatter = DateComponentsFormatter()
                    formatter.allowedUnits = [.hour, .minute]
                    formatter.unitsStyle = .short
                    let formattedString = formatter.string(from: TimeInterval(runtime))!
                    self.runTimeLabel.text = formattedString
                }
                
                if let releaseyear = self.unionInfo?.releaseYear {
                    self.releasedLabel.text = "\(releaseyear)"
                }
                
                self.snapShotHandler = {cell, indexPath in
                    var string = self.unionInfo!.snapShotUrl
                    string.insert(contentsOf: "_\(indexPath.row + 1)", at: string.index(string.endIndex, offsetBy: -4))
                    print(string)
                    
                    let urlString = URL(string: string)
                    cell.imageView.sd_setImage(with: urlString, completed: nil)
                    
                    if indexPath.row == 0 {
                        self.snapshotImageView.sd_setImage(with: urlString, completed: nil)
                    }
                }
                
                self.singleSelectImageHandler = {cell, indexPath in
                    
                    var string = self.unionInfo!.snapShotUrl
                    string.insert(contentsOf: "_\(indexPath.row + 1)", at: string.index(string.endIndex, offsetBy: -4))
                    
                    self.snapshotImageView.sd_setImage(with: URL(string: string), completed: nil)
                }
                
                self.videoController.nameLabel.text = self.unionInfo?.name
                self.name.text = self.unionInfo?.name
                self.genreLabel.text = self.unionInfo?.genre
                self.directorLabel.text = self.unionInfo?.director
                self.actorLabel.text = self.unionInfo?.actor
                self.storyLabel.text = self.unionInfo?.description
            }
        }
    }
    
    func unionInfo_fetch(productId: String) {
        
        let unionInfoUrl = "https://api.looktv.mn/api/product/union_info?productId=\(productId)"
        guard let url = URL(string: unionInfoUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(Union_Info.self, from: data)
                self.unionInfo = rootJSON
                self.videoController.unionInfoList = rootJSON.list
                count1 = self.unionInfo!.snapshotCount
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
    }
    
    
    var singleProductInfo: Union_Info? {
        didSet {
            DispatchQueue.main.async {
                if let runtime = self.singleProductInfo?.duration {
                    let formatter = DateComponentsFormatter()
                    formatter.allowedUnits = [.hour, .minute]
                    formatter.unitsStyle = .short
                    let formattedString = formatter.string(from: TimeInterval(runtime))!
                    self.runTimeLabel.text = formattedString
                }
                
                if let releaseyear = self.singleProductInfo?.releaseYear {
                    self.releasedLabel.text = "\(releaseyear)"
                }
                
                self.snapShotHandler = {cell, indexPath in
                    var string = self.singleProductInfo!.snapShotUrl
                    string.insert(contentsOf: "_\(indexPath.row + 1)", at: string.index(string.endIndex, offsetBy: -4))
                    print(string)
                    
                    let urlString = URL(string: string)
                    cell.imageView.sd_setImage(with: urlString, completed: nil)
                    
                    if indexPath.row == 0 {
                        self.snapshotImageView.sd_setImage(with: urlString, completed: nil)
                    }
                }
                
                self.singleSelectImageHandler = {cell, indexPath in
                    
                    var string = self.singleProductInfo!.snapShotUrl
                    string.insert(contentsOf: "_\(indexPath.row + 1)", at: string.index(string.endIndex, offsetBy: -4))
                    
                    self.snapshotImageView.sd_setImage(with: URL(string: string), completed: nil)
                }
                
                self.videoController.nameLabel.text = self.unionInfo?.name
                self.name.text = self.singleProductInfo?.name
                self.genreLabel.text = self.singleProductInfo?.genre
                self.directorLabel.text = self.singleProductInfo?.director
                self.actorLabel.text = self.singleProductInfo?.actor
                self.storyLabel.text = self.singleProductInfo?.description
            }
        }
    }
    
    func singleProduct_fetch(productId: String) {
        
        let unionInfoUrl = "https://api.looktv.mn/api/product/detail?productId=\(productId)"
        guard let url = URL(string: unionInfoUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(Union_Info.self, from: data)
                self.singleProductInfo = rootJSON
                count1 = self.unionInfo!.snapshotCount
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
                
            catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
    }
    
    var userStatus: Bool = true
    
    @objc func handleDownload() {
        
        if userStatus {
            let loginController = LoginController()
            present(loginController, animated: true)
        }
            
        else {
            showAlertView()
        }
    }
    
    @objc func handlePlay() {
        
        if userStatus {
            let loginController = LoginController()
            present(loginController, animated: true)
        }
            
        else {
            showAlertView()
        }
    }
}
