//
//  Alert.swift
//  Resume
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

struct SingleButtonAlert {
  let title: String
  let message: String?
  let action: AlertAction
}

struct AlertAction {
  let buttonTitle: String
  let handler: (() -> Void)?
}
