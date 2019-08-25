//
//  ProfileTableCell.swift
//  Resume
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell , Accessible{
  
  /// Model Object
  var profile : Profile?{
    didSet{
      guard let profile = profile else {
        return
      }
      userImageView.downloadedImage(from: profile.image)
      nameLabel.text = profile.name.uppercased()
      titleLabel.text = profile.title
      let location = profile.location.city + "," + profile.location.country
      setUpContactDetails(email: profile.email,
                          phone : profile.phone,
                          location : location)
    }
  }
  
  //MARK:- UI elements
  /// Profile ImageView
  private lazy var userImageView: UIImageView = {
    let imgView = UIImageView.init(image: UIImage.init(named: ImageIdefifiers.placeholder))
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
  /// User Name Label
  private lazy var nameLabel: UILabel = {
    let nameLbl = UILabelFactory.init(alignment : .center)
      .font(forTextStyle: .subheadline)
      .numberOf(lines: 0)
    return nameLbl
  }()
  
  /// Title Label
  private lazy var titleLabel: UILabel = {
    let titleLbl = UILabelFactory.init(alignment : .center)
      .font(forTextStyle: .headline)
      .numberOf(lines: 0).textColor(with: .blue)
    //titleLbl.isAccessibilityElement = true
    //titleLbl.accessibilityIdentifier = "titleLabel"
    return titleLbl
  }()
  
  
  
  //MARK:- Override Intializer method
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
   // isAccessibilityElement = true
    //accessibilityIdentifier = String(describing: self)
    
    // Adding Subviews
    addSubview(userImageView)
    addSubview(nameLabel)
    addSubview(titleLabel)
    
    // Add Constraints
    userImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         left: nil, bottom: nil, right: nil,
                         padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                         size: .init(width: 100, height: 100))
    userImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    userImageView.rounded(heightConstant: 100)
    
    nameLabel.anchor(top: userImageView.bottomAnchor,
                     left: leftAnchor,
                     bottom: nil,
                     right: rightAnchor,
                     padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    
    titleLabel.anchor(top: nameLabel.bottomAnchor,
                      left: leftAnchor,
                      bottom: nil,
                      right: rightAnchor,
                      padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    
    generateAccessibilityIdentifiers()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Stack View For Phone, email , location
  private  func setUpContactDetails(email: String, phone : String, location : String) {
    let stackView = UIStackView.init()
    stackView.distribution = .fill
    stackView.spacing = 5
    stackView.alignment = .fill
    stackView.axis = .vertical
    addSubview(stackView)
    let icons = ["email","phone", "location"]
    
    // Iterining to add subviews in STackView
    for content in [email, phone,location].enumerated(){
      
      // Sub elements
      let iconImage =  UIImage.init(named:icons[content.offset] )
      let contentLbl = UILabelFactory.init(text: content.element,alignment: .left)
        .font(forTextStyle: .body)
        .textColor(with: .darkGray)
        .numberOf(lines: 0)
      
      let container = UIView.createCustomView(forImage: iconImage, label: contentLbl)
      // Add Constraints
      
      stackView.addArrangedSubview(container)
    }
    
    stackView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor,
                     padding: .init(top: 10, left: 30, bottom: 10, right: 30))
  }
  
}
