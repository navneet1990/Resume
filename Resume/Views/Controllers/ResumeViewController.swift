//
//  ViewController.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit

class ResumeViewController: UIViewController , Accessible{
  
  //MARK:- UI elements
  
  /// TableView
  lazy var tableView: UITableView = {
    let tableView = UITableView.init()
    tableView.isHidden = true
    // Register tableView cells
    tableView.register(ProfileCell.self)
    tableView.register(SummaryCell.self)
    tableView.register(ExperienceCell.self)
    tableView.register(DefaultTableCell.self)
    tableView.register(LanguageCell.self)
    tableView.register(EducationCell.self)
    
    // Register table header
    tableView.register(SectionHeaderView.self)
    
    return tableView
  }()
  
  /// UILabel
  private  lazy var messageLabel: UILabelFactory = {
    return UILabelFactory.init(text: "", alignment: .center)
      .font(forTextStyle: .headline)
      .textColor(with: .darkGray)
  }()
  
  /// Bar button
  private lazy var refreshBarButton: UIBarButtonItem = {
    let refreshBarButton = UIBarButtonItem.init(barButtonSystemItem:.refresh,
                                                target: self, action: #selector(barButtonAction))
    refreshBarButton.tintColor = .black
    refreshBarButton.isEnabled = false
    refreshBarButton.accessibilityIdentifier = "refreshBarButton"
    return refreshBarButton
  }()
  
  /// Activity indicator
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView.init(style: .gray)
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()
  
  //MARK:- Lazy Variables
  
  /* View Model variable will be load lazily.
   It will be loaded in memory when called first time
   **/
  lazy var viewModel : ResumeViewModal = {
    let viewModel = ResumeViewModal()
    return viewModel
  }()
  
  
  //MARK:- View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    performViewModelBinding()
    assignTableViewDataSourceDelegates()
  }
  
  override func loadView() {
    super.loadView()
    
    view.backgroundColor = .white
    title = "Resume"
    view.accessibilityIdentifier = "ResumeViewController"
    // Settting UI elements
    addSubViews()
    addContraints()
    generateAccessibilityIdentifiers()
    
  }
  
  //MARK:- IBActions
  @IBAction  func barButtonAction(_ sender: UIBarButtonItem) {
    viewModel.refreshBarButtonTapped()
  }
}
//MARK:- UI elements initiailization
private extension ResumeViewController{
  
  func addSubViews(){
    view.addSubview(tableView)
    view.addSubview(activityIndicator)
    view.addSubview(messageLabel)
    navigationItem.rightBarButtonItem = refreshBarButton
  }
  
  func addContraints(){
    tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor)
    
    activityIndicator.center = view.center
    activityIndicator.center.y = view.center.y - 100
    
    messageLabel.anchor(top: activityIndicator.bottomAnchor,
                        left: view.safeAreaLayoutGuide.leftAnchor,
                        bottom: nil,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        padding: .init(top: 20, left: 10, bottom: 0, right: 10))
    
  }
  /// TableView
  func assignTableViewDataSourceDelegates() {
    tableView.dataSource = self
    tableView.delegate = self
  }
}

//MARK:-Private extension for handling view model unbinding
private extension ResumeViewController{
  
  //Perfrom UI updates by unbinding from View Model
  func performViewModelBinding(){
    // Add default View model Values
    let spinnerDetails: (shouldSpin: Bool, message: String) = viewModel.activityIndicatorDetails.value
    spinnerDetails.shouldSpin ?
      activityIndicator.startAnimating() :
      activityIndicator.stopAnimating()
    messageLabel.text = spinnerDetails.message
    refreshBarButton.isEnabled = viewModel.shouldEnableRefresh.value
    
    
    /// Unbind items
    // Load Resume data from View model
    viewModel.resume.bind {[] (resume) in
      DispatchQueue.main.async {[weak self] in
        self?.tableView.isHidden = false
        self?.tableView.reloadData()
      }
    }
    // Update Activity Indicator details
    viewModel.activityIndicatorDetails.bind { (spinDetails: (shouldSpin:Bool,message:String)) in
      
      DispatchQueue.main.async {[unowned self] in
        spinDetails.shouldSpin == true ?
          self.activityIndicator.startAnimating():
          self.activityIndicator.stopAnimating()
        self.messageLabel.text = spinDetails.message
      }
      
    }
    // Show alert Controller
    viewModel.showAlert.bind {[weak self] (alert) in
      
      guard let alert = alert else {return}
      DispatchQueue.main.async {
        self?.showAlertMessage(singleButtonAlert: alert)
      }
    }
    
    // Bar Button
    viewModel.shouldEnableRefresh.bind { (isEnabled) in
      DispatchQueue.main.async { [unowned self] in
        self.refreshBarButton.isEnabled = isEnabled
      }
    }
    // After display default values, fetch data from servce
    viewModel.fetchResume()
  }
}

//MARK:- UITableView DataSource Methods
extension ResumeViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard  let _ = viewModel.resume.value else {
      return 0
    }
    return  viewModel.headers.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.resume.value?.countTableRows(forSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = Section(rawValue: indexPath.section)
    
    guard let category = section, let resume = viewModel.resume.value else {
      return .init()
    }
    if category == .profile ,
      let cell = tableView.dequeueReusableCell(ProfileCell.self, for: indexPath) {
      cell.profile = resume.profile
      return cell
    }
    else if category == .summary ,
      let cell = tableView.dequeueReusableCell(SummaryCell.self, for: indexPath){
      cell.summary = resume.summary
      return cell
    }
    else if category == .experience ,
      let cell = tableView.dequeueReusableCell(ExperienceCell.self, for: indexPath){
      cell.experience = resume.experience[indexPath.row]
      return cell
    }
    else if category == .skills ,
      let cell = tableView.dequeueReusableCell(DefaultTableCell.self, for: indexPath){
      cell.skill = resume.skills[indexPath.row]
      return cell
    }
    else if category == .languages ,
      let cell = tableView.dequeueReusableCell(LanguageCell.self, for: indexPath){
      cell.language = resume.languages[indexPath.row]
      return cell
    }
    else if category == .education ,
      let cell = tableView.dequeueReusableCell(EducationCell.self, for: indexPath){
      cell.education = resume.education[indexPath.row]
      return cell
    }
    return .init()
  }
}

//MARK:- UITableView Delegate Methods
extension ResumeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let view = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: SectionHeaderView.identifier)
      as? SectionHeaderView
      else {
        return nil
    }
    view.header = viewModel.headers[section]
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return viewModel.headers[section] != "" ? 50 : 0
  }
  
}

