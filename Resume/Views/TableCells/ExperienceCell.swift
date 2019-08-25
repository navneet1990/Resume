//
//  ExperienceCell.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell ,Accessible{
  
  /// Model Object
  var experience : Experience?{
    didSet{
      guard let experience = experience else {
        return
      }
      titleLabel.text =  experience.position
      companyNameLabel.text = experience.company
      aboutCompanyLabel.text = experience.summary
      responsibilitiesLabel.showMultiline(stringList:experience.highlights,
                                          textStyle: .body)
      durationLabel.text = experience.startDate + " - " + experience.endDate
      locationLabel.text = experience.location
    }
  }
  
  //MARK:- UI elements
  /// ROle Label
  private lazy var titleLabel: UILabel = {
    let titleLbl = UILabelFactory.init()
      .font(forTextStyle: .headline)
      .numberOf(lines: 0)
    return titleLbl
  }()
  
  /// Employer Name Label
  private lazy var companyNameLabel: UILabel = {
    let titleLbl = UILabelFactory.init()
      .font(forTextStyle: .subheadline)
      .numberOf(lines: 0).textColor(with: .blue)
    return titleLbl
  }()
  
  /// ABout Company label
  private lazy var aboutCompanyLabel: UILabel = {
    let aboutLbl = UILabelFactory.init(alignment : .left)
      .font(forTextStyle: .body)
      .numberOf(lines: 0)
    return aboutLbl
  }()
  
  /// Duties Label
  private lazy var responsibilitiesLabel: UILabel = {
    let dutiesLbl = UILabelFactory.init(alignment : .left)
      .font(forTextStyle: .body)
      .numberOf(lines: 0)
    return dutiesLbl
  }()
  
  /// Duration Label
  private lazy var durationLabel: UILabel = {
    let durationLbl = UILabelFactory.init(alignment : .left)
      .font(forTextStyle: .caption2)
      .numberOf(lines: 1)
    return durationLbl
  }()
  
  /// Location Label
  private lazy var locationLabel: UILabel = {
    let locLbl = UILabelFactory.init(alignment : .left)
      .font(forTextStyle: .caption2)
      .numberOf(lines: 1)
    return locLbl
  }()
  
  
  //MARK:- Override Intializer method
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let calendarImage = UIImage.init(named: ImageIdefifiers.calendar)
    let locationImage = UIImage.init(named: ImageIdefifiers.location)
    
    let durationView = UIView.createCustomView(forImage: calendarImage, label: durationLabel)
    let locationView = UIView.createCustomView(forImage: locationImage, label: locationLabel)
    
    let contentsStackViews = setUpStackView(subViews: [durationView,locationView],
                                            spacing: 0, axis: .horizontal,
                                            alignment: .leading, distribution: .fillEqually)
    
    let contentStackView = setUpStackView(subViews: [titleLabel, companyNameLabel,contentsStackViews, aboutCompanyLabel, responsibilitiesLabel])
    
    addSubview(contentStackView)
    contentStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    
    generateAccessibilityIdentifiers()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Custom StackView Method
  private func setUpStackView(subViews : [UIView],spacing: CGFloat = 10,
                              axis: NSLayoutConstraint.Axis = .vertical,
                              alignment : UIStackView.Alignment = .fill,
                              distribution: UIStackView.Distribution = .fill)-> UIStackView{
    
    let stackView = UIStackView.init(arrangedSubviews: subViews)
    stackView.distribution = distribution
    stackView.spacing = spacing
    stackView.alignment = alignment
    stackView.axis = axis
    addSubview(stackView)
    return stackView
  }
}
