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

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        //authenticate user here and fill in user info through authentication process 
        user.authenticateUser(in: self)
        self.loginButton.isHidden = true
        self.enterButton.isHidden = false // this should animate in :) should be complete after all the info is complete, or else risk not having all information loaded in next VC 
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterButton.isHidden = true
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
        let destinationVC = segue.destination as? UserBoardsCollectionVC
        destinationVC?.user = self.user
        destinationVC?.navigationItem.title! = "\(user.username.capitalized)'s Boards"
    }
    

}
