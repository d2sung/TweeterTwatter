//
//  User.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/27/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenName: NSString?
    var profileURL: NSURL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? NSString
        screenName = dictionary["screen_name"] as? NSString
        
        let profileURLString =
            dictionary["profile_image_url_https"] as? String
        
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)
        }
        
        
        tagline = dictionary["description"] as? String

        
    }
    
    static var _currentUser: User?
    
    
    class var currentUser: User?{
        get {
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                
                _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        
        
        set(user){
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
            
                defaults.set(data, forKey: "currentUserData")
            } else{
                defaults.removeObject(forKey: "currentUserData")
            }
            
            //defaults.set(user, forKey: "currentUser")
            
            defaults.synchronize()
        }
    }

}
