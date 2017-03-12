//
//  TweetViewController.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 3/5/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    var tweet: Tweet? = nil;

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWith((tweet?.profileImageURL)!)
        
        nameLabel.text = tweet?.name
        usernameLabel.text = tweet?.username
        textLabel.text = tweet?.text
        retweetLabel.text = String(describing: tweet!.retweetCount)
        favoriteLabel.text = String(describing: tweet!.favoritesCount)
        let timeString = "\(tweet?.timeStamp)"
        dateLabel.text = timeString
        
         retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
    
        
        //Set button icons
        if (tweet?.retweeted)! {
            let image = UIImage(named: "retweet-icon-green")
            self.retweetButton.setImage(image, for: UIControlState.normal)
        }
        
        else {
            let image = UIImage(named: "retweet-icon")
            self.retweetButton.setImage(image, for: UIControlState.normal)
        }
        
        if (tweet?.favorited)! {
            let image = UIImage(named: "favor-icon-red")
            self.favoriteButton.setImage(image, for: UIControlState.normal)
        }
            
        else {
            let image = UIImage(named: "favor-icon")
            self.favoriteButton.setImage(image, for: UIControlState.normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func retweetPressed(_ sender: Any) {
        if (tweet?.retweeted)! {
            TwitterClient.sharedInstance?.unRetweet(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
              
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            let image = UIImage(named: "retweet-icon")
            
            self.retweetButton.setImage(image, for: .normal)
            
             tweet?.retweeted = false
             tweet?.retweetCount =  (tweet?.retweetCount)! - 1
        }
        
            
        else {
            print(tweet?.statusID)
            TwitterClient.sharedInstance?.retweet(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            let image = UIImage(named: "retweet-icon-green")
            self.retweetButton.setImage(image, for: UIControlState.normal)
            
            tweet?.retweetCount =  (tweet?.retweetCount)! + 1
            tweet?.retweeted = true
        }
        
         retweetLabel.text = String (tweet!.retweetCount)
    
    }
  
    @IBAction func favPressed(_ sender: Any) {
        
        if (tweet?.favorited)!{
            TwitterClient.sharedInstance?.unFav(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            let image = UIImage(named: "favor-icon")
            self.favoriteButton.setImage(image, for: UIControlState.normal)
            
            tweet?.favoritesCount = (tweet?.favoritesCount)! - 1
            tweet?.favorited = false;

        }
        
        else {
            TwitterClient.sharedInstance?.fav(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            let image = UIImage(named: "favor-icon-red.png")
            self.favoriteButton.setImage(image, for: UIControlState.normal)
            
            tweet?.favoritesCount = (tweet?.favoritesCount)! + 1
            tweet?.favorited = true;
        }
        
        favoriteLabel.text = String(tweet!.favoritesCount)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "replySegue"){
            let nextScene = segue.destination as! ComposeViewController
            nextScene.recipient = usernameLabel.text
            nextScene.fromReply = true;
        }
        
    
    

}
}
