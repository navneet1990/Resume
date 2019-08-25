//
//  UILabelFactory.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

final class UILabelFactory : UILabel{
  
  init(text : String = "", alignment: NSTextAlignment = .left){
    super.init(frame: .zero)
    self.text = text
    textAlignment = alignment
    textColor = .black
   }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Public methods
  func font(forTextStyle style: UIFont.TextStyle) -> Self {
    font = UIFont.preferredResumeFont(forTextStyle: style)
    return self
  }
  
  func textColor(with color: UIColor) -> Self {
    textColor = color
    return self
  }
  
  func numberOf(lines: Int) -> Self {
    numberOfLines = lines
    return self
  }
}
