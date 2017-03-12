//
//  ComposeViewController.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 3/6/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetField: UITextView!
    var recipient: String!
    var fromReply: Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetField.becomeFirstResponder()
        
        if fromReply {
            tweetField.text = "@" + recipient
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
    @IBAction func tweetButtonPressed(_ sender: Any) {
        let text = tweetField.text
        
        let params = "status=\(text)&display_coordinates=false"
        
        TwitterClient.postUpdate(status: text!, callBack: { (tweet, error) in
            self.tweetField.text = ""
            self.tweetField.endEditing(true)
        })
        
    
    
    }

}
