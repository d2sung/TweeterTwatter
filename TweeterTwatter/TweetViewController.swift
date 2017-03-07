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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func replyPressed(_ sender: Any) {
    }
 
    
    @IBAction func retweetPressed(_ sender: Any) {
        if (tweet?.retweeted)! {
            TwitterClient.sharedInstance?.unRetweet(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                let image = UIImage(named: "retweet-icon")
                self.retweetButton.setImage(image, for: .normal)
 
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
             tweet?.retweeted = false
             tweet?.retweetCount =  (tweet?.retweetCount)! - 1
        }
        
            
        else {
            print(tweet?.statusID)
            TwitterClient.sharedInstance?.retweet(id: (tweet?.statusID)!, success: { (tweet: Tweet) in
                
                let image = UIImage(named: "retweet-icon-green")

                
                self.retweetButton.setImage(image, for: .normal)
           
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            tweet?.retweetCount =  (tweet?.retweetCount)! + 1
            tweet?.retweeted = true
            
          
        }
    
    }
  
    @IBAction func favPressed(_ sender: Any) {
    
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
