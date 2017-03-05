//
//  PinDetailVC.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/2/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit
import PinterestSDK

class PinDetailVC: UIViewController {
    
    var selectedPin: PDKPin!
    var boardContainingPin: PDKBoard!
    let store = PinterestUserDataStore.sharedInstance

    @IBOutlet weak var selectedPinImage: UIImageView!
    @IBOutlet weak var pinDescriptionLabel: UILabel!
    @IBOutlet weak var boardNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func seePinButtonTapped(_ sender: Any) {
        UIApplication.shared.open(selectedPin.pinURL, options: [:]) { (openedPin) in
            print("opening webpage to view pin")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedPinImage.setImageWith(selectedPin.largestImage().url)
        
        self.boardNameLabel.text = boardContainingPin.name
        self.pinDescriptionLabel.text = selectedPin.descriptionText
        self.usernameLabel.text = store.user.currentUser.username
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
