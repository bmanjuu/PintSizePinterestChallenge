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
        
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? PinDetailVC
        
        let indexPath = collectionView!.indexPathsForSelectedItems!.first!
        let selectedPin = self.selectedBoardPins[indexPath.row]
        destinationVC?.selectedPin = selectedPin
        destinationVC?.boardContainingPin = self.selectedBoard
    }
    

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
        cell.pinImageView.setImageWith(pin.largestImage().url)
        cell.descriptionText.text = pin.descriptionText
       
        cell.layer.cornerRadius = 6
        
        return cell
    }

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
        
        let height = annotationPadding + annotationHeaderHeight + 60.0 + annotationPadding
        // 60.0 is the height of the descriptionText label rounded up
        
        return height
    }
}
