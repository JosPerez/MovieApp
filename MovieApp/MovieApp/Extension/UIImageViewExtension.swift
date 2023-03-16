//
//  UIImageViewExtension.swift
//  MovieApp
//
//  Created by jose perez on 14/03/22.
//
import UIKit
extension UIImageView {
    private static var urlStore = [String:String]()
    func setImage(url: String, placeholderImage: UIImage? = nil, contentMode: ContentMode = .scaleAspectFit) {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        UIImageView.urlStore[tmpAddress] = url
        if let image = placeholderImage {
            self.image = image
        } else{
            self.backgroundColor = .gray
        }
        MAImageDownloader.shared.downloadAndCacheImage(url: url, onSuccess: { (image, url) in
            DispatchQueue.main.async {
            if UIImageView.urlStore[tmpAddress] == url {
                self.contentMode = contentMode
                self.image = image
                self.backgroundColor = .clear
                }
            }
        }) { error in
        }
    }
}
