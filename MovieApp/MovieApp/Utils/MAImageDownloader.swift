//
//  MAImageDownloader.swift
//  MovieApp
//
// Based on https://medium.com/macoclock/ios-uitableview-lazy-loading-of-images-dec1bd6d5dd5
import UIKit
class MAImageDownloader: NSObject {
    static let shared = MAImageDownloader()
    func downloadAndCacheImage(url:String, onSuccess:@escaping (_ image:UIImage?, _ url: String) -> Void, onFailure:@escaping (_ error:Error?) -> Void) -> Void {
        let finalUrl = URL(string: url)
        if let image = MAImageDownloadManager.shared.getImage(forUrl: url){
            onSuccess(image, url)
        }else{
            URLSession.shared.dataTask(with: finalUrl!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    onFailure(error)
                }else{
                    if let image = UIImage(data: data!){
                        MAImageDownloadManager.shared.setImage(image: image, forKey: url)
                        onSuccess(image, url)
                    }else{
                        onFailure(NSError(domain: "", code: 100, userInfo: ["reason":"Unable to download image"]))
                    }
                }
                
            }).resume()
        }
    }
}
class MAImageDownloadManager: NSObject {
    static let shared = MAImageDownloadManager()
    var imageCache:NSCache<NSString, UIImage>
    override init() {
        self.imageCache = NSCache()
    }
    func getImage(forUrl url:String) -> UIImage? {
        return self.imageCache.object(forKey: url as NSString)
    }
    func setImage(image:UIImage,forKey url:String) -> Void {
        self.imageCache.setObject(image, forKey: url as NSString)
    }
}
