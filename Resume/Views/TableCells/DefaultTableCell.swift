//
//  DefaultTableCell.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

class DefaultTableCell: UITableViewCell, Accessible {
  
  /// Modal Object
  var skill : Skills?{
    didSet{
      guard let skill = skill else {
        return
      }
      textLabel?.text = skill.name
      detailTextLabel?.numberOfLines = 0
      detailTextLabel?.text = skill.keywords.joined(separator: ", ")
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
