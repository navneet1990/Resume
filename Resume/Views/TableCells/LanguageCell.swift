//
//  LanguageCell.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com). All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell,Accessible {
  
  /// Language type object has information about language
  var language: Language?{
    didSet{
      guard  let language = language else {
        return
      }
      textLabel?.text = language.language
      detailTextLabel?.text = language.level
      displayRatingView(language.rating)
      
    }
  }
  
  /*  Rating view with using Stack View
   Blue colored Views defines rating
   Black colored views defines max level
   Expert rating = 5, intermediate = 3
   */
  private func displayRatingView(_ rate: Int){
    
    // Setting up stackView for rating circles
    let ratingStackView = UIStackView.init()
    ratingStackView.distribution = .fillEqually
    ratingStackView.spacing = 5
    ratingStackView.alignment = .center
    ratingStackView.axis = .horizontal
    
    addSubview(ratingStackView)
    
    // Run loop 5 times and fill with rating circles
    for index in 1...5{
      let circleView = UIView.init()
      
      circleView.backgroundColor = index > rate ? .black : .blue
      circleView.anchor( top: nil, left: nil, bottom: nil, right: nil,
                         size: .init(width: Constants.IconDimensions.height,
                                     height: Constants.IconDimensions.height))
      ratingStackView.addArrangedSubview(circleView)
      circleView.rounded(heightConstant: Constants.IconDimensions.height)
      
    }
    
    // Adding constraints
    ratingStackView.anchor(top: nil, left: nil, bottom: nil,
                           right: rightAnchor,
                           padding: .init(top: 0, left: 0, bottom:0, right: 50),
                           size: .zero)
    ratingStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
  }
  
  
  //MARK:- Override Intializer method
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    detailTextLabel?.textColor = .lightGray
    textLabel?.numberOfLines = 0
    accessibilityIdentifier = reuseIdentifier
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
