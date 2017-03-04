//
//  PinFeedCollectionVC.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/3/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit
import AVFoundation
import PinterestSDK

private let reuseIdentifier = "pin"

class PinFeedCollectionVC: UICollectionViewController {
    
    var selectedBoard: PDKBoard!
    var selectedBoardPins: [PDKPin]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? PinterestCustomLayout {
            layout.delegate = self
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(self.selectedBoardPins.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PinCustomCell
    
        let pin = self.selectedBoardPins[indexPath.row]
        let pinImage = ImageHelper.obtainImagefrom(link: pin.largestImage().url)
        
        cell.pinImageView.frame = CGRect(x: cell.pinImageView.frame.origin.x, y: cell.pinImageView.frame.origin.x, width: cell.pinImageView.frame.width, height: pinImage.size.height)
        
        cell.pinImageView.image = pinImage
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension PinFeedCollectionVC: PinterestCustomLayoutDelegate {
    
    func collectionView(collectionView:UICollectionView,
                        heightForPhotoAtIndexPath indexPath: NSIndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let pin = self.selectedBoardPins[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: CGSize(width: pin.largestImage().width, height: pin.largestImage().height), insideRect: boundingRect)
        
        return rect.size.height
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: NSIndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        let pin = self.selectedBoardPins[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = pin.heightForComment(font: font, width: width, pin: pin)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return height
    }
}

extension PDKPin {
    
    func heightForComment(font: UIFont, width: CGFloat, pin: PDKPin) -> CGFloat {
        let rect = NSString(string: pin.descriptionText).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
}
