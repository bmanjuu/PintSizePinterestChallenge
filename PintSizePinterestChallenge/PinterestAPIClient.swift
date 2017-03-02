//
//  PinterestAPIClient.swift
//  PintSizePinterestChallenge
//
//  Created by Betty Fung on 3/1/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation
import PinterestSDK

struct PinterestAPIClient {
    
    static let baseURL = "https://api.pinterest.com/v1/"
    
    static func obtainUserURL() -> String {
        var userURL = ""
        
        return userURL
    }
    
}

//MARK: - Download Images
extension PinterestAPIClient {
    static func downloadDataFromImageURL(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    static func obtainImagefrom(link: URL) -> UIImage {
        var imageData = Data()
        print("IMAGE LINK: \(link)")
        
        downloadDataFromImageURL(url: link) { (data, response, error) in
            guard let data = data, error == nil else { return }
            imageData = data
        }
        
        while imageData.isEmpty {
            // print("retrieving image data")
        }
        
        return UIImage(data: imageData)!
        
    }
}
