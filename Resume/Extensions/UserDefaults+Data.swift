//
//  UserDefaults+Data.swift
//  Resume
//
//  Created by Navneet Singh on 24/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

extension UserDefaults {
  var resume: Data? {
    get { return data(forKey: #function) }
    set { setValue(newValue, forKey: #function) }
  }
}
