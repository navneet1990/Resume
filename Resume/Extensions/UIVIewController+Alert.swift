//
//  UIVIewController+Alert.swift
//  Resume
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

protocol Presentable: class {
  func showAlertMessage(singleButtonAlert alert : SingleButtonAlert)
}

extension  UIViewController: Presentable {
  
  func showAlertMessage(singleButtonAlert alert : SingleButtonAlert)  {
    let alertController = UIAlertController(title: alert.title,
                                            message: alert.message,
                                            preferredStyle:.alert)
    alertController.addAction(UIAlertAction(title: alert.action.buttonTitle,
                                            style: .default,
                                            handler: { _ in alert.action.handler?() }))
    
    self.present(alertController, animated: true, completion: nil)
  }
}
