//
//  Accessible.swift
//  Resume
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

protocol Accessible {
  /// create Accessiblity idenfiters 
  func generateAccessibilityIdentifiers()
}

extension Accessible {
  
  func generateAccessibilityIdentifiers() {
    let mirror = Mirror(reflecting: self)
    for child in mirror.children {
      if
        let view = child.value as? UIView,
        let identifier = child.label?.replacingOccurrences(of: ".storage", with: "") {
        view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
      }
    }
  }
}
