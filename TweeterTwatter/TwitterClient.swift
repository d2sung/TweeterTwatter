//
//  TwitterClient.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/27/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "BPBv88dXWGa9aOzhmCJTohxfD", consumerSecret: 	"uBqyPKJq70QaMlO25UA8OXwx0WWyfbapc6PEYgOX2dzOF16MPT")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()){
        
        self.loginSuccess = success
        self.loginFailure = failure
        
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "TweeterTwatter://oauth") as URL!, scope: nil, success: {(requestToken: BDBOAuth1Credential?)-> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            
            UIApplication.shared.openURL(url as URL)
            
        }, failure: {(error: Error?) -> Void in
            print("error")
            self.loginFailure?(error as! NSError)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
        
        
        
    }
    
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error as NSError)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> () ){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
        
        
    }
    
    func handleOpenURL(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential?) -> Void in
            
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
            }, failure: {(error: Error?) -> Void in
            print("error")
            self.loginFailure?(error as! NSError)
        })
    }
    
    
    func postStatus(text: String, completion: (NSError) -> ()){
        post("1.1/statuses/update.json", parameters: text, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            print("successful tweet")
        
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("unsuccesful tweet")
        })
}
    
    
    //Tweet Function
    
    class func postUpdate(status: String, callBack: @escaping (_ response: Tweet?, _ error: Error?) -> Void) {
        
        let encodedTweet = status.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        TwitterClient.sharedInstance?.post("https://api.twitter.com/1.1/statuses/update.json?status=" + encodedTweet!, parameters: nil, progress: nil, success: { (URLSessionDataTask, response: Any?) -> Void in
            print ("successful tweet")
           
            
        }, failure: { (URLSessionDataTask, error: Error) -> Void in
            print(error.localizedDescription)
        })
    }

    
    
    func retweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error)->()) {
        
        post("1.1/statuses/retweet/\(id).json", parameters: ["id": id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            print ("successful retweet")
        }) {
            
            (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        }
    }
    
    func unRetweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error)->()) {
        
        post("1.1/statuses/unretweet/\(id).json", parameters: ["id": id], progress: nil, success: { (task: URLSessionTask, response: Any?) -> Void in
            
            print ("successful unretweet")
        
        } )
        
        {(task: URLSessionDataTask?, error: Error) in
            failure(error)

        }

    }
    
    
    func fav(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error)->()) {
        
        post("/1.1/favorites/create.json?id=" + String(id), parameters: ["id": id], progress: nil, success: {(task: URLSessionTask, response: Any?) -> Void in
        
            print("successful favorite")
            
        }) { (task: URLSessionTask?, error: Error) -> Void in
            failure(error)
        }
    }
    
    func unFav(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error)->()) {
        post("https://api.twitter.com/1.1/favorites/destroy.json?id=" + String(id), parameters: ["id": id], progress: nil, success: { (task: URLSessionTask, response: Any?) -> Void in
            
            print("successful unfavorite")
            
        }) { (task: URLSessionTask?, error: Error) -> Void in
            failure(error)
        }
    }
}
