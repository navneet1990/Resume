//
//  Resume+PropertyReflectable.swift
//  Resume
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

protocol PropertyReflectable { }

private extension PropertyReflectable {
  /// Subscript key to find rows
  subscript(countForKey key: String) -> Int {
    let m = Mirror(reflecting: self)
    let value = m.children.first { $0.label == key }?.value
    guard let array = value as? [Any] else {
      return 1
    }
    return array.count
  }
}

extension Resume : PropertyReflectable {
  /// Number of rows based upon section
  func countTableRows(forSection : Int)-> Int{
    guard  let category = Section(rawValue: forSection) else {
      return 0
    }
    return category == .summary ? 1 : self[countForKey: String(describing: category)]
  }
}
