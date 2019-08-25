//
//  SectionHeaderView.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com). All rights reserved.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView, Accessible {
  
  var header: String?{
    didSet{
      guard let header = header else {
        return
      }
      headerLabel.text = header
    }
  }
  /// Header Label
  private lazy var headerLabel: UILabel = {
    let headerLbl = UILabelFactory.init()
      .font(forTextStyle: .subheadline)
      .numberOf(lines: 0)
      .textColor(with: .white)
    return headerLbl
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .black
    contentView.addSubview(headerLabel)
    
    headerLabel.anchor(top: topAnchor,
                       left: leftAnchor,
                       bottom: bottomAnchor,
                       right: nil,
                       padding: .init(top: 10, left: 20, bottom: 10, right: 0))
    }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
