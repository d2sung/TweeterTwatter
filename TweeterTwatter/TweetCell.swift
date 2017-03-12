//
//  TweetCell.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/27/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!

    var tweet: Tweet!{
        didSet{
            nameLabel.text = tweet.name
            userNameLabel.text = "@" + tweet.username!
            
            let dateFormatter = DateFormatter()
        
            let s = dateFormatter.string(from: tweet.timeStamp!)
            
            timeStampLabel.text = s
            profileImageView.setImageWith(tweet.profileImageURL!)
            tweetTextLabel.text = tweet.text
            
            retweetCountLabel.text = String (tweet.retweetCount)
            favCountLabel.text = String(tweet.favoritesCount)
            
            
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews();
        retweetCountLabel.text = String (tweet.retweetCount)
        favCountLabel.text = String(tweet.favoritesCount)
        
        //Set button icons
        if (tweet?.retweeted)! {
            let image = UIImage(named: "retweet-icon-green")
            retweetButton.setImage(image, for: UIControlState.normal)
        }
            
        else {
            let image = UIImage(named: "retweet-icon")
            retweetButton.setImage(image, for: UIControlState.normal)
        }
        
        if (tweet?.favorited)! {
            let image = UIImage(named: "favor-icon-red")
            favButton.setImage(image, for: UIControlState.normal)
        }
            
        else {
            let image = UIImage(named: "favor-icon")
            favButton.setImage(image, for: UIControlState.normal)
        }

    }
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func onFavorite(_ sender: Any) {
        
        if (tweet?.favorited)!{
            TwitterClient.sharedInstance?.unFav(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            let image = UIImage(named: "favor-icon")
            self.favButton.setImage(image, for: UIControlState.normal)
            
            tweet?.favoritesCount = (tweet?.favoritesCount)! - 1
            tweet?.favorited = false;
            
        }
            
        else {
            TwitterClient.sharedInstance?.fav(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            let image = UIImage(named: "favor-icon-red.png")
            self.favButton.setImage(image, for: UIControlState.normal)
            
            tweet?.favoritesCount = (tweet?.favoritesCount)! + 1
            tweet?.favorited = true;
        }

        
        
        favCountLabel.text = String (tweet.favoritesCount)

    }
    
    @IBAction func onRetweet(_ sender: Any) {
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
        
        retweetCountLabel.text = String (tweet.retweetCount)
    }
}
