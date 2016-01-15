//
//  SafariActivity.swift
//  otanistudio
//
//  Created by Robert Otani on 7/18/15.
//  Copyright © 2015 Robert Otani. All rights reserved.
//

import UIKit

class SafariActivity: UIActivity {
    var URL: NSURL?
    
    override func activityType() -> String? {
        return String(self.dynamicType)
    }
    
    override func activityTitle() -> String? {
        return "Open in Safari"
    }
    
    override func activityImage() -> UIImage? {
        return UIImage(named: "icon_safari_ios8")
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        var canPerform = false
        activityItems.forEach { (obj) -> () in
            if let URL = obj as? NSURL where UIApplication.sharedApplication().canOpenURL(URL) {
                canPerform = true
                return
            }
        }
        return canPerform
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        activityItems.forEach { (obj) -> () in
            if let URL = obj as? NSURL where UIApplication.sharedApplication().canOpenURL(URL) {
                self.URL = URL
                return
            }
        }
    }
    
    func activityCategory() -> UIActivityCategory {
        return .Action
    }
    
    override func performActivity() {
        guard let urlForSafari = URL else {
            activityDidFinish(false)
            return
        }
        let finish = UIApplication.sharedApplication().openURL(urlForSafari)
        activityDidFinish(finish)
    }
}
