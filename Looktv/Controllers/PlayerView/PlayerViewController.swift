//
//  PlayerViewController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 7/25/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit
import AVFoundation
import NVActivityIndicatorView
import MediaPlayer

private var playerViewControllerKVOContext = 0

class PlayerViewController: UIViewController, UIGestureRecognizerDelegate, NVActivityIndicatorViewable{
    
    static let assetKeysRequiredToPlay = [
        "playable",
        "hasProtectedContent"
    ]
    
    var unionInfoList = [UnionInfo_List]()
    
    
    //MARK:- labels and buttons and uiviews
    
    let seperatorLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textColor = .white
        label.text = "/"
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 10)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        label.textColor = .white
        label.text = "Name Label"
        label.font = UIFont(name: "Verdana", size: 16)
        return label
    }()
    
    let rewindView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }()
    
    let fastForwardView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }()
    
//    let rewindButton: UIButton = {
//        let button = UIButton()
//        button.clipsToBounds = true
//        button.contentMode = .scaleAspectFill
//        button.addTarget(self, action: #selector(handleRewind), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    let fastForwardButton: UIButton = {
//        let button = UIButton()
//        button.clipsToBounds = true
//        button.contentMode = .scaleAspectFill
//        button.addTarget(self, action: #selector(handleFastforward), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    let dismissbutton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icon_category_open"), for: .normal)
        return button
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "player_icon"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let lockButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .blue
        button.setImage(#imageLiteral(resourceName: "player_icon"), for: .normal)
        return button
    }()
    
    let playerView: PlayerView = {
        let view = PlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = .black
        view.isUserInteractionEnabled = true
        return view
    }()

    let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var playerSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: self.transparentView.frame.width, height: 40))
        slider.tintColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    
    
    //MARK:- player items and instance
    @objc let player = AVPlayer()
    
    var currentTime: Double {
        get {
            return CMTimeGetSeconds(player.currentTime())
        }
        set {
            let newTime = CMTimeMakeWithSeconds(newValue, preferredTimescale: 1)
            player.seek(to: newTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
    
    var duration: Double {
        guard let currentItem = player.currentItem else { return 0.0 }
        return CMTimeGetSeconds(currentItem.duration)
    }
    
    var rate: Float {
        get {
            return player.rate
        }

        set {
            player.rate = newValue
        }
    }
    
    var asset: AVURLAsset? {
        didSet {
            guard let newAsset = asset else { return }
            asynchronouslyLoadURLAsset(newAsset)
        }
    }

    private var playerLayer: AVPlayerLayer? {
        return playerView.playerLayer
    }


    let timeRemainingFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
    
    
    private var timeObserverToken: Any?

    private var playerItem: AVPlayerItem? = nil {
        didSet {
            player.replaceCurrentItem(with: self.playerItem)
        }
    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playerView)
        playerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        playerView.addSubview(volumeView)
        playerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePlayerViewTap)))
        
        setupTransparentView()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addObserver(self, forKeyPath: #keyPath(PlayerViewController.player.currentItem.duration), options: [.new, .initial], context: &playerViewControllerKVOContext)

        addObserver(self, forKeyPath: #keyPath(PlayerViewController.player.rate), options: [.new, .initial], context: &playerViewControllerKVOContext)

        addObserver(self, forKeyPath: #keyPath(PlayerViewController.player.currentItem.status), options: [.new, .initial], context: &playerViewControllerKVOContext)
        
        playerView.playerLayer.player = player
        
        get_url(unionInfoList: unionInfoList[0])
        
        let interval = CMTimeMake(value: 1, timescale: 1)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [unowned self] time in
            let timeElapsed = Float(CMTimeGetSeconds(time))
            self.playerSlider.value = Float(timeElapsed)
            self.startTimeLabel.text = self.createTimeString(time: timeElapsed)
        }
    }
    
    
    //    MARK:- viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }

        player.pause()

        removeObserver(self, forKeyPath: #keyPath(PlayerViewController.player.currentItem.duration), context: &playerViewControllerKVOContext)
        removeObserver(self, forKeyPath: #keyPath(PlayerViewController.player.rate), context: &playerViewControllerKVOContext)
        removeObserver(self, forKeyPath: #keyPath(PlayerViewController.player.currentItem.status), context: &playerViewControllerKVOContext)
        
        playerView.playerLayer.player = nil
    }

    // MARK: - Asset Loading
    
    func asynchronouslyLoadURLAsset(_ newAsset: AVURLAsset) {

        newAsset.loadValuesAsynchronously(forKeys: PlayerViewController.assetKeysRequiredToPlay) {
            
            DispatchQueue.main.async {
                
                guard newAsset == self.asset else { return }
                
                for key in PlayerViewController.assetKeysRequiredToPlay {
                    var error: NSError?

                    if newAsset.statusOfValue(forKey: key, error: &error) == .failed {
                        let stringFormat = NSLocalizedString("error.asset_key_%@_failed.description", comment: "Can't use this AVAsset because one of it's keys failed to load")

                        let message = String.localizedStringWithFormat(stringFormat, key)

                        self.handleErrorWithMessage(message, error: error)

                        return
                    }
                }

                if !newAsset.isPlayable || newAsset.hasProtectedContent {
                    let message = NSLocalizedString("error.asset_not_playable.description", comment: "Can't use this AVAsset because it isn't playable or has protected content")

                    self.handleErrorWithMessage(message)

                    return
                }
                
                self.playerItem = AVPlayerItem(asset: newAsset)
            }
        }
    }
    
    //MARK:- handleButtons
    @objc func handleDismissButton() {
        playerView.playerLayer.player = nil
//        playerView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLockButton() {
        print("Lock button tapped")
//        transparentView.removeFromSuperview()
//        transparentView.isUserInteractionEnabled = false
    }
    
    @objc func sliderDidChange(_ sender: UISlider) {
        currentTime = Double(sender.value)
    }
    
    @objc func handlePlayPause() {
        if player.rate != 1.0 {
            if currentTime == duration {
                currentTime = 0.0
            }

            player.play()
        }
        else {
            player.pause()
        }
    }

    @objc func handleRewind() {
        // Rewind no faster than -2.0.
        rate = max(player.rate - 2.0, -2.0)
    }

    @objc func handleFastforward() {
        // Fast forward no faster than 2.0.
        rate = min(player.rate + 2.0, 2.0)
    }

    //MARK:- handle views tap
    @objc func handleTransparentViewTap(gesture: UITapGestureRecognizer) {
        print("TransparentView tapped")
        gesture.view?.removeFromSuperview()
        transparentView.removeFromSuperview()
    }
    
    @objc func handlePlayerViewTap(gesture: UITapGestureRecognizer) {
        print("PlayerView tapped")
        setupTransparentView()
    }
    
    
    //MARK:- observing the keyPath of playerView
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        guard context == &playerViewControllerKVOContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        if keyPath == #keyPath(PlayerViewController.player.currentItem.duration) {
            
            let newDuration: CMTime
            if let newDurationAsValue = change?[NSKeyValueChangeKey.newKey] as? NSValue {
                newDuration = newDurationAsValue.timeValue
            }
            else {
                newDuration = CMTime.zero
            }

            let hasValidDuration = newDuration.isNumeric && newDuration.value != 0
            let newDurationSeconds = hasValidDuration ? CMTimeGetSeconds(newDuration) : 0.0
            let currentTime = hasValidDuration ? Float(CMTimeGetSeconds(player.currentTime())) : 0.0

            playerSlider.maximumValue = Float(newDurationSeconds)

            playerSlider.value = currentTime

//            rewindButton.isEnabled = hasValidDuration

            playPauseButton.isEnabled = hasValidDuration

//            fastForwardButton.isEnabled = hasValidDuration
            
            playerSlider.isEnabled = false

            startTimeLabel.isEnabled = hasValidDuration
            startTimeLabel.text = createTimeString(time: currentTime)

            durationLabel.isEnabled = hasValidDuration
            durationLabel.text = createTimeString(time: Float(newDurationSeconds))
        }
        
        else if keyPath == #keyPath(PlayerViewController.player.rate) {
        
            let newRate = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).doubleValue

            let buttonImageName = newRate == 1.0 ? "pause" : "player_icon"

            let buttonImage = UIImage(named: buttonImageName)

            playPauseButton.setImage(buttonImage, for: UIControl.State())
        }
            
        else if keyPath == #keyPath(PlayerViewController.player.currentItem.status) {
            
            let newStatus: AVPlayerItem.Status

            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItem.Status(rawValue: newStatusAsNumber.intValue)!
            }
            else {
                newStatus = .unknown
            }

            if newStatus == .failed {
                handleErrorWithMessage(player.currentItem?.error?.localizedDescription, error:player.currentItem?.error)
            }
        }
    }

    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        let affectedKeyPathsMappingByKey: [String: Set<String>] = [
            "duration":     [#keyPath(PlayerViewController.player.currentItem.duration)],
            "rate":         [#keyPath(PlayerViewController.player.rate)]
        ]
        return affectedKeyPathsMappingByKey[key] ?? super.keyPathsForValuesAffectingValue(forKey: key)
    }
    
    //MARK:- handle error message of playerView
    func handleErrorWithMessage(_ message: String?, error: Error? = nil) {
        NSLog("Error occured with message: \(message ?? ""), error: \(error ?? "" as! Error).")
//
        let alertTitle = NSLocalizedString("alert.error.title", comment: "Alert title for errors")
        let defaultAlertMessage = NSLocalizedString("error.default.description", comment: "Default error message when no NSError provided")

        let alert = UIAlertController(title: alertTitle, message: message == nil ? defaultAlertMessage : message, preferredStyle: UIAlertController.Style.alert)

        let alertActionTitle = NSLocalizedString("alert.error.actions.OK", comment: "OK on error alert")

        let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)

        alert.addAction(alertAction)

        present(alert, animated: true, completion: nil)
    }
    
    func createTimeString(time: Float) -> String {
        let components = NSDateComponents()
        components.second = Int(max(0.0, time))
        return timeRemainingFormatter.string(from: components as DateComponents)!
    }
    
    
    //MARK:- API fetch
    var video: Video! {
        didSet {
            if let trailerURL = URL(string: self.video.trailerList[0].url) {
                print("Movie url: \(trailerURL)")
                asset = AVURLAsset(url: trailerURL, options: nil)
            }
        }
    }
    
    func get_url(unionInfoList: UnionInfo_List) {

        let unionInfoUrl = "https://api.looktv.mn/api/product/get_url_new?productId=\(unionInfoList.productId)"
        
        guard let url = URL(string: unionInfoUrl) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch dat: ", err)
                return
            }
            guard let data = data else {return}

            do {
                let rootJSON = try JSONDecoder().decode(Video.self, from: data)
                self.video = rootJSON
                
            }

            catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
    }
    
    //MARK:- MPVolumeView
    lazy var volumeView: MPVolumeView = {
        let volume = MPVolumeView(frame: self.view.bounds)
        volume.backgroundColor = .clear
        volume.showsVolumeSlider = false
        return volume
    }()
    
    fileprivate func changeSpeakerSliderPanelControls(volume: Float) {
        for subview in self.volumeView.subviews {
            if subview.description.range(of: "MPVolumeSlider") != nil {
                let slider = subview as! UISlider
                slider.minimumValue = 0
                slider.maximumValue = player.volume
                slider.value = volume
                break
            }
        }
    }
    
    //MARK:- setup gestures
    fileprivate func setupGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTransparentViewTap))
        transparentView.addGestureRecognizer(tapGesture)
        
        let volumeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransparentPan))
        transparentView.addGestureRecognizer(volumeGesture)
    }
    
    //MARK:- setupTransparentView
    fileprivate func setupTransparentView() {
        
        view.addSubview(transparentView)
        transparentView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        transparentView.addSubview(volumeView)
        
        setupGestures()

        transparentView.addSubview(playPauseButton)
        playPauseButton.centerInSuperview()
        playPauseButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(), size: CGSize(width: 80, height: 80))
        playPauseButton.layer.cornerRadius = 80 / 2

        transparentView.addSubview(dismissbutton)
        dismissbutton.anchor(top: transparentView.topAnchor, leading: transparentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))

        transparentView.addSubview(nameLabel)
        nameLabel.centerXInSuperview()
        nameLabel.anchor(top: transparentView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))

        transparentView.addSubview(playerSlider)
        playerSlider.anchor(top: nil, leading: transparentView.leadingAnchor, bottom: transparentView.bottomAnchor, trailing: transparentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 0), size: CGSize(width: 0, height: 0))

        transparentView.addSubview(startTimeLabel)
        startTimeLabel.anchor(top: playerSlider.bottomAnchor, leading: transparentView.leadingAnchor, bottom: transparentView.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: CGSize(width: 50, height: 0))

        transparentView.addSubview(seperatorLabel)
        seperatorLabel.anchor(top: playerSlider.bottomAnchor, leading: startTimeLabel.trailingAnchor, bottom: transparentView.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))

        transparentView.addSubview(durationLabel)
        durationLabel.anchor(top: playerSlider.bottomAnchor, leading: seperatorLabel.trailingAnchor, bottom: transparentView.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 6, bottom: 0, right: 0), size: CGSize(width: 50, height: 0))


        transparentView.addSubview(lockButton)
        lockButton.centerXInSuperview()
        lockButton.anchor(top: playerSlider.bottomAnchor, leading: nil, bottom: transparentView.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 0, bottom: 5, right: 0), size: CGSize(width: 30, height: 30))
        lockButton.addTarget(self, action: #selector(handleLockButton), for: .touchUpInside)
    }
  
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         return true
    }
    
    @objc func handleTransparentPan(gesture: UIPanGestureRecognizer) {
        
        let viewWidth = transparentView.frame.width / 2
        let translation = gesture.translation(in: transparentView)
//        let x = translation.x
        let y = translation.y
       
        
        if gesture.location(in: transparentView).x > viewWidth {
            if y < 0 {
                print("volume up")
                
//                if player.volume < maxVolume {
//                    player.volume = player.volume + 5
//                    changeSpeakerSliderPanelControls(volume: player.volume)
//                }
            }
            else {
                print("volume down")
                
                if player.volume > 0 {
                    player.volume = player.volume - 5
                    changeSpeakerSliderPanelControls(volume: player.volume)
                }
            }
            
        }
            
        else {
            if y < 0 {
                print("Brightness up")
            }
            else {
                print("Brightenss down")
            }
        }
    }
}
