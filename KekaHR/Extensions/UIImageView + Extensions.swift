//
//  UIImageView + Extensions.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import UIKit
import Foundation
import Kingfisher

extension UIImageView {
    func loadImage(_ imageURL: String) {
        guard let url: URL = URL.init(string: imageURL) else {
            return
        }
        KF.url(url)
            .fade(duration: 1)
            .onSuccess { print($0) }
            .onFailure { err in print("Error: \(err)") }
            .set(to: self)
    }
    
    func cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
    
    func setIndicatorType() {
        kf.indicatorType = .activity
    }
    
    func simpleLoadImage(_ imageURL: String) {
        guard let url = URL(string: imageURL) else {
            return
        }
        kf.setImage(with: url)
    }
}
