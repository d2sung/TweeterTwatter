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
    
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    
    var tweet: Tweet!{
        didSet{
            nameLabel.text = tweet.name
            userNameLabel.text = tweet.username
            //timeStampLabel.text = tweet.timeStamp
            profileImageView.setImageWith(tweet.profileImageURL!)
            tweetTextLabel.text = tweet.text
            self.retweetCount = tweet.retweetCount;
            self.favoritesCount = tweet.favoritesCount;
            
            retweetCountLabel.text = String (self.retweetCount)
            favCountLabel.text = String (self.favoritesCount)
            
            print("Retweet count: \(self.retweetCount)")
            
            print ("Fav count: \(self.favoritesCount)")
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
        
        favoritesCount = favoritesCount + 1
        
        
              favCountLabel.text = String (self.favoritesCount)

    }
    
    @IBAction func onRetweet(_ sender: Any) {
        retweetCount = retweetCount + 1
        retweetCountLabel.text = String (self.retweetCount)
    }
    

}
