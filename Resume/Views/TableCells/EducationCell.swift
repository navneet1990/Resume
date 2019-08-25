//
//  EducationCell.swift
//  Resume
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

class EducationCell: UITableViewCell, Accessible {
  
  /// Language type object has information about language
  var education: Education?{
    didSet{
      guard  let education = education else {
        return
      }
      institutionLabel.text = education.school
      studyTypeLabel.text = education.category + " in " + education.area
      durationLabel.text = education.startDate + " - " + education.endDate
      cgpaLabel.text = "\(education.cgpa)"
    }
  }
  
  
  //MARK:- UI ELements
  /// Institution Label
  private lazy var institutionLabel: UILabel = {
    let nameLbl = UILabelFactory.init()
      .font(forTextStyle: .headline)
      .numberOf(lines: 0)
      .textColor(with: .blue)
    return nameLbl
  }()
  
  /// Study Type Label
  private lazy var studyTypeLabel: UILabel = {
    let titleLbl = UILabelFactory.init()
      .font(forTextStyle: .subheadline)
      .numberOf(lines: 0)
    return titleLbl
  }()
  
  /// DUration Label
  private lazy var durationLabel: UILabel = {
    let durLbl = UILabelFactory.init()
      .font(forTextStyle: .caption1)
    return durLbl
  }()
  
  /// CGPA Label
  private lazy var cgpaLabel: UILabel = {
    let cgpaLbl = UILabelFactory.init(alignment: .right)
      .font(forTextStyle: .subheadline)
      .textColor(with: .blue)
    return cgpaLbl
  }()
  
  
  //MARK:- Overide initialisers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // Creating Duration View
    let calendarImage = UIImage.init(named: ImageIdefifiers.calendar)
    let durationView = UIView.createCustomView(forImage: calendarImage,
                                               label: durationLabel)
    
    // Add to superView
    addSubview(durationView)
    addSubview(institutionLabel)
    addSubview(studyTypeLabel)
    
    
    // Add constraints
    studyTypeLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: nil, right: nil,
                          padding: .init(top: 10, left: 10, bottom: 0, right: 0),
                          size: .init(width: Constants.screenSize.width/2 + 10,
                                      height: 0))
    institutionLabel.anchor(top: studyTypeLabel.bottomAnchor,
                            left: leftAnchor,
                            bottom: nil, right: nil,
                            padding: .init(top: 5, left: 10, bottom: 0, right: 0),
                            size: .init(width: Constants.screenSize.width/2 + 10,
                                        height: 0))
    
    durationView.anchor(top: institutionLabel.bottomAnchor,
                        left: leftAnchor,
                        bottom: bottomAnchor,
                        right: nil,
                        padding: .init(top: 10, left: 10, bottom: 10, right: 0))
    
    setUpScoreView()
    generateAccessibilityIdentifiers()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /** Score View That shows CGPA
   It has
   * Middle divider view of gray color
   * Header Label
   * Score Label
   * Overall Score Label
   */
  private func setUpScoreView(){
    // Middle divider
    let divider = UIView.init()
    divider.backgroundColor = .lightGray
    
    // Header of score
    let cgpaHeader = UILabelFactory.init(text: "CGPA", alignment: .center)
      .textColor(with: .lightGray).font(forTextStyle: .caption1)
    let totalCGPALbl = UILabelFactory.init(text: "10.0", alignment: .left)
      .textColor(with: .lightGray).font(forTextStyle: .subheadline)
    let dividerLbl = UILabelFactory.init(text: "/", alignment: .center)
      .textColor(with: .lightGray).font(forTextStyle: .subheadline)
    
    // StackView for CGPA
    let stackView = UIStackView.init(arrangedSubviews: [cgpaLabel,dividerLbl,totalCGPALbl])
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    
    // Add to superview
    addSubview(stackView)
    addSubview(divider)
    addSubview(cgpaHeader)
    
    // Adding Constraints
    divider.anchor(top: nil,
                   left: institutionLabel.rightAnchor,
                   bottom: nil, right: nil,
                   padding: .init(top: 0, left: 10, bottom: 0, right: 0),
                   size: .init(width: 2, height: 50))
    divider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    cgpaHeader.anchor(top: divider.topAnchor,
                      left: divider.rightAnchor,
                      bottom: nil,
                      right: rightAnchor,
                      padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    stackView.anchor(top: cgpaHeader.bottomAnchor,
                     left: divider.rightAnchor,
                     bottom: nil,
                     right: rightAnchor,
                     padding: .init(top: 10, left: 10, bottom: 0, right: 10))
  }
}
