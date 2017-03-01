//
//  BoardCollectionViewCell.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit
import Foundation

class BoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var boardImageView: UIImageView!
    @IBOutlet weak var boardNameLabel: UILabel!
    
    static func downloadDataFromImageURL(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    static func obtainImagefrom(link: URL) -> UIImage {
        var boardImageData = Data()
        
        downloadDataFromImageURL(url: link) { (data, response, error) in
            guard let data = data, error == nil else { return }
            boardImageData = data
        }
        
        while boardImageData.isEmpty {
            print("retrieving image data")
        }
        
        print("data: \(boardImageData)")
        return UIImage(data: boardImageData)!
        
    }
}
