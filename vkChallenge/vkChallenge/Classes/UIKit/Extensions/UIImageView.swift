//
//  UIImageView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension BaseImageView {
    
    func imageFrom(url: URL?) {
        guard let url = url else {
            image = nil
            return
        }
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data, let fetchedImage = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    imageCache.setObject(fetchedImage, forKey: url.absoluteString as NSString)
                    if url == self?.url {
                        self?.image = fetchedImage
                    }
                })
            }
            
        }
        dataTask.resume()
    }
}
