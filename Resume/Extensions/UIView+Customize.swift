//
//  UIView+Customize.swift
//  Resume
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

extension UIView{
  
  /// Combine two views in 1
  ///
  /// - Parameters:
  ///   - image: Image View
  ///   - label: UIlable
  /// - Returns: Add both above in container view
  static func createCustomView(forImage image: UIImage?,
                               label: UILabel)-> UIView{
    guard let image = image else {
      return .init()
    }
    let containerView = UIView()
    let imageView = UIImageView.init(image: image)
    imageView.contentMode = .scaleAspectFit
    containerView.addSubview(imageView)
    containerView.addSubview(label)
    
    let view1Arrange :(UIView,UIEdgeInsets,CGSize) = (imageView,
                                                      .init(top: 0,left: 10,bottom: 0,right: 0),
                                                      .init(width: 20, height: 20))
    
    let view2Arrange :(UIView,UIEdgeInsets,CGSize) = (label,
                                                      .init(top:0,left:10,bottom:0,right: 10),
                                                      .zero)
    containerView.arrangeSubsViews(view1: view1Arrange,view2: view2Arrange)
    return containerView
  }
  
  /// Arranging SubViews in container view
  ///
  /// - Parameters:
  ///   - v1: First view to be arranged
  ///   - v2: Second view to be arranged
  private  func arrangeSubsViews(view1 v1:(view:UIView,padding: UIEdgeInsets, size: CGSize),
                                 view2 v2:(view:UIView,padding: UIEdgeInsets , size: CGSize) ){
    
    // Add Constraints
    v1.view.anchor(top: nil,
                   left: leftAnchor,
                   bottom: nil, right: nil,
                   padding: v1.padding,
                   size: v1.size)
    v1.view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    
    v2.view.anchor(top: topAnchor,
                   left: v1.view.rightAnchor,
                   bottom: bottomAnchor,
                   right:rightAnchor,
                   padding: v2.padding,
                   size: v2.size)
    v2.view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
  }
}

// Properties
extension UIView{
  
  /// Round the UIView type element
  ///
  /// - Parameter value: rounded valye
  func rounded(heightConstant value: CGFloat?)  {
    let radius = (value ?? self.frame.width)/2.0
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
}
