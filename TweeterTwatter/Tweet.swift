//
//  Tweet.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/27/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var name: String?
    var username: String?
    var profileImageURL: URL?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let tweetUser = User.init(dictionary: (dictionary["user"]) as! NSDictionary)
        
        username = tweetUser.screenName as String?
        name = tweetUser.name as String?
        
        profileImageURL = tweetUser.profileURL as URL?
        
        let timeStampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        if let timeStampString = timeStampString{
            timeStamp = formatter.date(from: timeStampString) as Date?
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
        
    }

}
