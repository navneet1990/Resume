//
//  UIFont+Styles.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

extension UIFont {
  
  /// Custom fonts
  ///
  /// - Parameter style: Text Style
  /// - Returns: UIFont
  public static func preferredResumeFont(forTextStyle style: UIFont.TextStyle = .body) -> UIFont {
    var defaultFont: UIFont?
    switch style {
    case .body:
      defaultFont = UIFont(name: "HelveticaNeue", size: 15)
      
    case .headline:
      defaultFont = UIFont(name: "HelveticaNeue-Bold", size: 20)
      
    case .subheadline:
      defaultFont = UIFont(name: "HelveticaNeue-Medium", size: 18)
      
    case .footnote:
      defaultFont = UIFont(name: "HelveticaNeue-Light", size: 13)
      
    case .caption1:
      defaultFont = UIFont(name: "HelveticaNeue-Light", size: 12)
      
    case .caption2:
      defaultFont = UIFont(name: "HelveticaNeue-Light", size: 11)
      
    default:
      defaultFont = UIFont.systemFont(ofSize: 17)
    }
    return defaultFont ?? UIFont.systemFont(ofSize: 17)
  }
}
