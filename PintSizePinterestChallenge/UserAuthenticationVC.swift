//
//  UserAuthenticationVC.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit
import PinterestSDK
import NVActivityIndicatorView

class UserAuthenticationVC: UIViewController {
    
    var user: User = User() //create empty/new user
    let store = PinterestUserDataStore.sharedInstance
    

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView.isHidden = true
        self.enterButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        self.loginButton.isHidden = true
        self.store.user.authenticateUser(in: self)
        
        let loadingActivityIndicator = NVActivityIndicatorView(frame: self.activityIndicatorView.frame, type: .ballScaleRippleMultiple, color: UIColor.lightGray, padding: 0.0)
        self.view.addSubview(loadingActivityIndicator)
        
        
        DispatchQueue.main.async {
            //display animation while user is being authenticated and while retrieving data
            self.activityIndicatorView.isHidden = false
            loadingActivityIndicator.startAnimating()
        }
        
        DispatchQueue.global(qos: .background).async {
            //check status of retrieving data in the background
            while !self.store.finishedRetrievingData {
                print("waiting")
            }
            
            //once data has been retrieved, stop animation and make enter button available 
            DispatchQueue.main.async {
                loadingActivityIndicator.stopAnimating()
                self.enterButton.isHidden = false
            }
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // let destinationVC = segue.destination as? UserBoardsCollectionVC
        // destinationVC?.user = self.user
        // destinationVC?.navigationItem.title! = "\(user.username.capitalized)'s Boards"
    }
    

}
