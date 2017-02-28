//
//  TweetsViewController.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/27/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            print(tweets.count)
             self.tableView.reloadData()
        
        }, failure: { (error: NSError) -> () in
            print ("error")
        })
        
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell
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
