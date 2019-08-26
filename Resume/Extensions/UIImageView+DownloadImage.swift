//
//  UIImageView+DownloadImage.swift
//  Resume
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

protocol DownloadImage {
  
  /// Image From Server
  ///
  /// - Parameters:
  ///   - link: link of image location
  ///   - mode: content mode
  func downloadedImage(from link: String?, contentMode mode: UIView.ContentMode)
}
extension UIImageView : DownloadImage{
  
  // Download Image From Server
  private  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { [weak self]data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse,
        httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self?.image = image
      }
      }.resume()
  }
  func downloadedImage(from link: String?,
                       contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    ///Check if test case running
    if isTestCaseRunning(){
      image = Constants.Mock.image
      return
    }
    
    guard let link = link ,let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}

extension UIImageView : TestingEnvironment{}
