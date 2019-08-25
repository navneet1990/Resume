//
//  UITableViewCell+Identifiable.swift
//  Resume
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

extension UITableView {
  func register<T: UITableViewHeaderFooterView>(_ headerClass: T.Type) {
    register(headerClass, forHeaderFooterViewReuseIdentifier: T.identifier)
  }
  
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass.self, forCellReuseIdentifier: T.identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(_: T.Type,
                                               for indexPath: IndexPath) -> T? {
    return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
  }
}

