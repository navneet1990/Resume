//
//  PlastiResumeiewModelProtocol.swift
//  PlasticChallenge
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet. All rights reserved.
//

import Foundation

protocol ViewModelProtocol : class {
  //Variables
  var resume: Bindable<Resume?> {get set}
  var showAlert: Bindable<(SingleButtonAlert)?>{get set}
  var activityIndicatorDetails: Bindable<(Bool,String)>{get set}
  var shouldEnableRefresh: Bindable<Bool> {get set}
  
  // Methods
  func fetchResume()
  func refreshBarButtonTapped()
}
