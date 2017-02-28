//
//  LoginViewController.swift
//  TweeterTwatter
//
//  Created by Daniel Sung on 2/27/17.
//  Copyright © 2017 Daniel Sung. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(_ sender: Any) {
        
        let client = TwitterClient.sharedInstance
        
        client?.login(success: { 
            print("logged in")
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: {_ in
            print("Error")
        })
    
        
        
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
