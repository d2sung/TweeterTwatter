//
//  ProfileViewController.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/28/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetsNumLabel: UILabel!
    @IBOutlet weak var followingNumLabel: UILabel!
    @IBOutlet weak var followerNumLabel: UILabel!
    
    @IBOutlet weak var composeButton: UIBarButtonItem!
    
    var userProfileBool: Bool = true
    var tweet: Tweet! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (userProfileBool){
            nameLabel.text = User.currentUser?.name as String?;
            usernameLabel.text = User.currentUser?.screenName as String?
            tweetsNumLabel.text = "\(User.currentUser!.tweetsNum)"
            followingNumLabel.text = "\(User.currentUser!.followingNum)"
        
            followerNumLabel.text = "\(User.currentUser!.followerNum)"
            
            profileImageView.setImageWith(User.currentUser?.profileURL as! URL)
        }
        
        else {
            composeButton.isEnabled = false
            composeButton.tintColor = UIColor.clear
            let user = tweet!.user
            
            tweetsNumLabel.text = "\(user?["statuses_count"] as! Int)"
            
            nameLabel.text = user?["name"] as! String?
            usernameLabel.text = user?["screen_name"] as! String?
            followerNumLabel.text = "\(user?["followers_count"] as! Int)"
            followingNumLabel.text = "\(user?["friends_count"] as! Int)"
            
            let imageURL = "\(user?["profile_image_url_https"] as! String)"
 
            profileImageView.setImageWith(URL(string: imageURL)!)
        
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
