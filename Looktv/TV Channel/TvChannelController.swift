//
//  TvChannelController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/1/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit
import SDWebImage

extension Dictionary where Value: RangeReplaceableCollection {
    public mutating func append(element: Value.Iterator.Element, toValueOfKey key: Key) {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension TvChannelController {

    func timeFormat() -> String {
        let date = Date()
        let year = date.string(format: "yyyy")
        let month = date.string(format: "MM")
        let day = date.string(format: "dd")

        let dateString = year + month + day + "000000"//hour + minute + second

        return dateString
    }

    func fetchScheduledPrograms(channelID: String, dateString: String, order: Int, indexPath: IndexPath?) {

        let scheduleUrl = "https://api.looktv.mn/api/schedule/bypass_list_by_hour?fromHour=0&toHour=24&scheduleDt=\(dateString)&platformId=2c9f807e51955cea0151a5f6a83200ab&channelId=\(channelID)"

        guard let url = URL(string: scheduleUrl) else {return}
      
        URLSession.shared.dataTask(with: url) { (data, responce, err) in
            if let err = err {
                print("Failed tp fetch data: ", err)
                return
            }
            guard let data = data else {return}

            do {
                var rootJSON = try JSONDecoder().decode(ByPassList.self, from: data)
                rootJSON.channelId = channelID
                rootJSON.requestDate = dateString
                
                
                if rootJSON.list.isEmpty == false {
                   
                    if order < 0 {
//                        bypassDictionary.popFirst()
                        
                        if var data = bypassDictionary[channelID] {
                            data.insert(rootJSON, at: 0)
                        }
//                        bypassDictionary.append(element: rootJSON, toValueOfKey: channelID)
                        rootJSON.requestedChannelNumber = rootJSON.list[0].channelNumber
                        
                        DispatchQueue.main.async {
                            self.scheduleTableView.reloadData()
                        }
                    }
                        
                    else {
                        if rootJSON.requestedChannelNumber == rootJSON.list[0].channelNumber {
                            return
                        }
                            
                        else {
                            bypassDictionary.append(element: rootJSON, toValueOfKey: channelID)
                            rootJSON.requestedChannelNumber = rootJSON.list[0].channelNumber
                            
                            DispatchQueue.main.async {
                                self.scheduleTableView.reloadData()
                            }
                        }
                    }
                }
            }
            
            catch let jsonErr {
                print(jsonErr)
            }
            
        }.resume()
    }
}

extension TvChannelController {
  
    func fetchChannels() {
        let channelUrl = "https://api.looktv.mn/api/channel/list_by_package?platformId=2c9f807e51955cea0151a5f6a83200ab"
        
        guard let url = URL(string: channelUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}
            do {
                let rootJSON = try JSONDecoder().decode(TvListByPackage.self, from: data)
                self.channelPackageList = rootJSON.channelPackageList
                
            }
            catch let jsonErr {
                print(jsonErr)
            }
            
            DispatchQueue.main.async {
                self.channelTableView.reloadData()
            }
            
            }.resume()
        }
}

extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy: i)];
        }
    }
}

extension TvChannelController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == channelTableView {
            return channelPackageList[section].channelList.count
        }
        else {
            if let data = bypassDictionary[channelID] {
                if data[section].list.isEmpty == false {
                    print(data[section].list[0].schedules.count)
                    return data[section].list[0].schedules.count
                }
            }
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == channelTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TvChannelCell
            
            cell.channelLabel.text = channelPackageList[indexPath.section].channelList[indexPath.row].name
            
            cell.channelImageView.sd_setImage(with: URL(string: channelPackageList[indexPath.section].channelList[indexPath.row].imageUrl), completed: nil)
            
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor(red: 0 / 255, green: 180 / 255, blue:  90 / 255, alpha: 1)
            cell.selectedBackgroundView = selectedBackgroundView
            
            return cell
        }
        
        if tableView == scheduleTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! TvScheduleCell
            
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor(red: 0 / 255, green: 180 / 255, blue:  90 / 255, alpha: 1)
            cell.selectedBackgroundView = selectedBackgroundView
            
            if let bypass = bypassDictionary[channelID] {
                cell.scheduleTime.text = bypass[indexPath.section].list[0].schedules[indexPath.row].scheduleTime
                cell.nameLabel.text = bypass[indexPath.section].list[0].schedules[indexPath.row].name
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == channelTableView {
            
            name.text = channelPackageList[indexPath.section].channelList[indexPath.row].name
            
            let dateString = timeFormat()
            
            self.channelID = self.channelPackageList[indexPath.section].channelList[indexPath.row].id
            guard let channelid = channelID else {return}
            
            self.fetchScheduledPrograms(channelID: channelid, dateString: dateString, order: 0, indexPath: indexPath)
        }
        
        if tableView == scheduleTableView {
            
            if let data = bypassDictionary[channelID] {
                let message = data[indexPath.section].list[0].schedules[indexPath.row].name
                
                let alert = UIAlertController(title: "Do you want to play?", message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView == scheduleTableView {
            
            if let data = bypassDictionary[channelID] {
                let requestDate = data[indexPath.section].requestDate

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                formatter.timeZone = TimeZone(identifier: "UTC")
                let date = formatter.date(from: requestDate!)
                let calendar = Calendar(identifier: .gregorian)

                if indexPath.section == data.count - 1 && indexPath.row == data[indexPath.section].list[0].schedules.count - 1 {

                    if data[indexPath.section].list.isEmpty == false {

                        let dayAfter = calendar.date(byAdding: .day, value: +1, to: date!, wrappingComponents: false)

                        fetchScheduledPrograms(channelID: channelID, dateString: formatter.string(from: dayAfter!), order: 1, indexPath: indexPath)

                    }
                }
                    
                else {
//                    let dayBefore = calendar.date(byAdding: .day, value: -1, to: date!, wrappingComponents: false)
//                    
//                    fetchScheduledPrograms(channelID: channelID, dateString: formatter.string(from: dayBefore!), order: -1, indexPath: indexPath)
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == channelTableView {
            return channelPackageList.count
        }
        else {
            if bypassDictionary.count > 0 {
                if let data = bypassDictionary[channelID] {
                    let count = data.count
                    return count
                }
            }
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print(time)
        
        if tableView == channelTableView {
            let sectionView = UIView()
            channelLabel.clipsToBounds = true
            channelLabel.contentMode = .scaleAspectFill
            channelLabel.backgroundColor = .clear
            channelLabel.text = channelPackageList[section].name
            channelLabel.font = UIFont(name: "Verdana-Bold", size: 9)
            channelLabel.textColor = .white
            
            sectionView.addSubview(channelLabel)
            channelLabel.anchor(top: sectionView.topAnchor, leading: sectionView.leadingAnchor, bottom: sectionView.bottomAnchor, trailing: nil, padding: .init(top: 7, left: 10, bottom: 7, right: 0))
            sectionView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
            
            return sectionView
        }
        
        if tableView == scheduleTableView {
            let sectionView = UIView()
            let label = UILabel()
            label.clipsToBounds = true
            label.contentMode = .scaleAspectFill
            label.backgroundColor = .clear
            
            if let data = bypassDictionary[channelID] {
                label.text = data[section].requestDate
            }
            
            label.font = UIFont(name: "Verdana-Bold", size: 9)
            label.textColor = .white
            
            sectionView.addSubview(label)
            label.anchor(top: sectionView.topAnchor, leading: sectionView.leadingAnchor, bottom: sectionView.bottomAnchor, trailing: nil, padding: .init(top: 7, left: 10, bottom: 7, right: 0))
            sectionView.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
            
            return sectionView
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == channelTableView {
            return 45
        }
        return 50
    }
    
    fileprivate func setupTableView(tableView: UITableView) {
        view.addSubview(tableView)
        tableView.anchor(top: segmentedControl.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        tableView.showsVerticalScrollIndicator = false
    }
}


extension TvChannelController {
    
    fileprivate func setupPlayerView() {
        
        let drmVideoPlayer = DRMVideoPlayer()
       
        drmVideoPlayer.assetId = "8a01918b6bdecde0016c0a678bde20cb-3"
        drmVideoPlayer.streamUrl = "https://cdn.looktv.mn/2c9f807e51955cea0151a5f6a83200ab/origin_2/channel/smil:hbo_sig.smil/playlist.m3u8"
        
        view.addSubview(drmVideoPlayer.view)
        drmVideoPlayer.view.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 210))
        
//        self.present(drmVideoPlayer, animated: true)
        
        // segment
        let items = [channelsLabel.text, catchUpLabel.text]
        segmentedControl = UISegmentedControl(items: items as [Any])
        segmentedControl.customize(for: 20)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegment), for: .valueChanged)
        
        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: drmVideoPlayer.view.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 48))
    }
    
    @objc func handleSegment(_ segment: UISegmentedControl) {
        
        switch segment.selectedSegmentIndex {
        case 0:
            self.scheduleTableView.removeFromSuperview()
            self.setupTableView(tableView: channelTableView)
            
            DispatchQueue.main.async {
                self.scheduleTableView.reloadData()
            }
            
        case 1:
            self.channelTableView.removeFromSuperview()
            self.setupTableView(tableView: scheduleTableView)
        default:
            break
        }
    }
}

extension TvChannelController {
    
    @objc func handleOptionsButton() {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.addSubview(blackView)
        blackView.frame = view.frame
        blackView.alpha = 0
        handleOpen()
    }
    
    func handleOpen() {
        
        isMenuOpen = true
        
        self.setupMenuController()
        performAnimation(transfrom: CGAffineTransform(translationX: self.menuWidth, y: 0))
        blackViewAnimation()
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        blackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleViewPan)))
    }
    
    @objc func handleTapDismiss() {
        isMenuOpen = false
        self.performAnimation(transfrom: .identity)
        self.blackViewAnimation()
        self.menuController.view.transform = .identity
    }
    
    @objc func handleViewPan(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: blackView)
        var x = translation.x
        
        if gesture.state == .changed {
            
            if isMenuOpen {
                x += menuWidth
            }
            
            x = min(menuWidth, x)
            x = max(0, x)
            
            performAnimation(transfrom: CGAffineTransform(translationX: x, y: 0))
            blackView.alpha = x / menuWidth
        }
            
        else if gesture.state == .ended {
            handleEnded(gesture: gesture, view: blackView)
        }
    }
    
    func handleHide() {
        isMenuOpen = false
        self.performAnimation(transfrom: .identity)
        self.blackViewAnimation()
    }
    
    func handleEnded(gesture: UIPanGestureRecognizer, view: UIView) {
        
        let translation = gesture.translation(in: view)
        
        if isMenuOpen {
            if abs(translation.x) < menuWidth / 3 {
                handleOpen()
            } else {
                handleHide()
            }
        }
        else {
            handleOpen()
        }
    }
    
    fileprivate func performAnimation(transfrom: CGAffineTransform) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = transfrom
            self.view.transform = transfrom
            
        })
    }
    
    fileprivate func blackViewAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.layoutIfNeeded()
            self.blackView.alpha = self.isMenuOpen ? 1 : 0
        }
    }
    
    fileprivate func setupMenuController() {
        
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuController.view)
    }
}

extension UISegmentedControl {
    
    func customize(for height: Int) {
        
        setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name:"Helvetica Neue", size:15)!,NSAttributedString.Key.foregroundColor:UIColor.white], for:.normal)
        
        setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name:"Helvetica Neue", size:15)!,NSAttributedString.Key.foregroundColor:UIColor.white], for:.selected)
        
        setDividerImage(UIImage().colored(with: #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1), size: CGSize(width: 1, height: height)), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        setBackgroundImage(UIImage().colored(with: #colorLiteral(red: 0.1907136738, green: 0.1984122992, blue: 0.2357594967, alpha: 1), size: CGSize(width: 1, height: height)), for: .normal, barMetrics: .default)
        
        setBackgroundImage(UIImage().colored(with: #colorLiteral(red: 0.345725596, green: 0.3542075157, blue: 0.3954209089, alpha: 1) , size: CGSize(width: 1, height: height)), for: .selected, barMetrics: .default);
        
        for  borderview in subviews {
            let upperBorder: CALayer = CALayer()
            upperBorder.backgroundColor = UIColor.init(red: 215/255.0, green: 0.0, blue: 30/255.0, alpha: 1.0).cgColor
            upperBorder.frame = CGRect(x: 0, y: borderview.frame.size.height-1, width: borderview.frame.size.width, height: 1)
            borderview.layer.addSublayer(upperBorder)
        }
        
    }
}

class TvChannelController: UIViewController {
    
    //MARK:- instance variables
    let cellID = "cellID"
    fileprivate let menuWidth: CGFloat = 280
    fileprivate var isMenuOpen = false
    
    let menuController = MenuController()
    let blackView = UIView()
    var channelID: String!
    var channelPackageList = [ChannelPackageList_list]()
    var segmentedControl: UISegmentedControl!
    var lastContentOffset: CGFloat = 0
    
    let channelLabel = UILabel()
    
    let playerView: PlayerView = {
        let view = PlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = .black
        view.isUserInteractionEnabled = true
        return view
    }()
    
    //MARK:- view and labels
    lazy var channelTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.register(TvChannelCell.self, forCellReuseIdentifier: self.cellID)
        return tv
    }()
    
    lazy var scheduleTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.register(TvScheduleCell.self, forCellReuseIdentifier: "cellid")
        return tv
    }()
    
    let channelsLabel: UILabel = {
        let label = UILabel()
        label.text = "Channels"
        label.font = UIFont(name: "Verdana", size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let catchUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Catch-up"
        label.font = UIFont(name: "Verdana", size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    let name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        //        button.backgroundColor = .red
        button.setImage(#imageLiteral(resourceName: "btn_menu"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(handleOptionsButton), for: .touchUpInside)
        return button
    }()
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        //        button.backgroundColor = .red
        button.setImage(#imageLiteral(resourceName: "icon_cancel_white"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHomeButton), for: .touchUpInside)
        return button
    }()
    
    //MARK:- viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setupHeaderAndGradient()
        setupPlayerView()
        setupTableView(tableView: channelTableView)
        fetchChannels()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleHomeButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupHeaderAndGradient() {
        
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        headerView.addSubview(name)
        name.centerXInSuperview()
        name.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 250, height: 0))
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 375.0, height: 70.0)
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        headerView.addSubview(optionsButton)
        optionsButton.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 45, height: 45))
        
        headerView.addSubview(homeButton)
        homeButton.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 45, height: 45))
    }
}
