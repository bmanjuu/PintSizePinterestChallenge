//
//  UserAuthenticationVC.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit
import PinterestSDK

class UserAuthenticationVC: UIViewController {
    
    var user: User = User() //create empty/new user

    @IBAction func loginButtonTapped(_ sender: Any) {
        //authenticate user here
        user.authenticateUser(in: self) //fill in user info through authentication
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //USER OBJECT GETS FILLED IN HERE AND PASSED INTO VC Str
    }
    

}
