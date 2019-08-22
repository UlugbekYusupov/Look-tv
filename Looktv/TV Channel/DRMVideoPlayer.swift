//
//  DRMVideoPlayer.swift
//  Looktv
//
//  Created by Mirzoulugbek Yusupov on 8/22/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

import CastlabsSDK
import CastlabsOMA
import CastlabsDASH

class DRMVideoPlayer: UIViewController {
    
    var streamUrl: String?
    var assetId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CastlabsSDK .with([CastlabsDASH.init(), CastlabsOMA.init()],
                          andLicenseKey: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJidW5kbGVJZCI6Im1lLnVsdWdiZWsuTG9va3R2Iiwia2lkIjoxOTQ5LCJpbHYiOmZhbHNlfQ.vBLwt-s6VciVNDJif-mMArgX1ZgRXIvvvXzzct-tpJqZ40DfIcEmKZ2fvXcOLduMvxysfcACdwz7duJIBceM0A6ibwsa5_p39k_bEIRB1EpOLBN2A4K1BT47wC6MUDsJhJsvhF9tMF9c--kiqu9SSzZlrVRywgxcIh3wIhdMOlqTu7-4_PckOfl-RjROph1EJJCtCD6je7q2IXoauQevYdCoU98UyHY5jp8LKkxNmXeKOAMIGCGd6QKJPfqpg7Hsqp4vnRLHr99GzzhxBA4FopjZLTptlxm32IP3zL7g3UCjnj2T5ZYIAIhndHxeHZo-ZOZQXDiDfFylrAzTvTJBXw",
                          andDelegate: nil);
        
    }
    
    let applicationDocumentsDirectory: NSString = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let basePath: NSString = ((paths.count > 0) ? paths[0] as NSString : nil)!
        return basePath
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let bundle = Bundle(identifier: "castlabs.CastlabsSDK")
        let storyboard = UIStoryboard(name: "CLSDKStoryboard", bundle: bundle)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "CLPlayerViewController") as! CLPlayerViewController
        
        
        vc.streamUrl = self.streamUrl //"https://cdn.looktv.mn/2c9f807e51955cea0151a5f6a83200ab/origin_2/channel/smil:hbo_sig.smil/playlist.m3u8"
        vc.metadata = CLContentMetadata()
        vc.metadata?.title = "castLabs example stream"
        
        let configutation = CLDrmConfiguration()
        configutation.assetId = assetId
        configutation.merchantId = "giitd"
        configutation.sessionId = "a1d1f1p1"
        configutation.userId = "user-test"
        configutation.environment = DrmEnvironment.testing
        configutation.type = DrmType.oma
        configutation.tempDirectory = applicationDocumentsDirectory as String
        configutation.workingDirectory = NSTemporaryDirectory()
        vc.drmConfiguration = configutation
        
        self.present(vc, animated: true, completion: nil)
    }
}

