//
//  NSLayoutConstraint+Anchor.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

extension UIView{

  /// Contraints by enabling auto layout
  ///
  /// - Parameters:
  ///   - top: Top space anchor
  ///   - left: left space anchor
  ///   - bottom: bottom space anchor
  ///   - right: right space Anchor
  ///   - padding: Padding from top, left, bottom , right
  ///   - size: size of view
  func anchor( top: NSLayoutYAxisAnchor?,
               left: NSLayoutXAxisAnchor?,
               bottom : NSLayoutYAxisAnchor?,
               right: NSLayoutXAxisAnchor?,
               padding : UIEdgeInsets = .zero,
               size : CGSize = .zero) {
    
    // Required to turn on Constraints
    translatesAutoresizingMaskIntoConstraints = false
    
    // Top Space contraint
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
    }
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: padding.left ).isActive = true
    }
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
    }
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }
}
