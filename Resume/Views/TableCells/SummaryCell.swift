//
//  SummaryCell.swift
//  Resume
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell, Accessible {

  /// Summary Object
  var summary: [String]?{
    didSet{
      guard  let summary = summary else {
        return
      }
     multilineLabel.showMultiline(stringList: summary, textStyle: .body)
    }
  }
  
  //MARK:- UI Elements
  private lazy var multilineLabel: UILabel = {
    let multilineLbl = UILabelFactory.init().numberOf(lines: 0)
      return multilineLbl
  }()
  
  //MARK:- Override Intializer method
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(multilineLabel)
    
    // Add Cosntraints
    multilineLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    
    generateAccessibilityIdentifiers()
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
