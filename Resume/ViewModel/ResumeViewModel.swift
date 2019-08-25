//
//  ResumeViewModel.swift
//  Resume
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

final class ResumeViewModal : ViewModelProtocol{
  
  //MARK:- Variables
  private(set) var networkManager: NetworkManager?
  //  private(set)
  
  var showAlert: Bindable<(SingleButtonAlert)?> = Bindable(nil)
  var shouldEnableRefresh: Bindable<Bool> = Bindable(false)
  var activityIndicatorDetails: Bindable<(Bool,String)> = Bindable((true,"Loading..."))
  var resume: Bindable<Resume?> = Bindable(nil)
  let headers: [String] = ["","Summary",
                           "Experience", "Technical Skills",
                           "Education","Languages"]
  
  /* private resume variable
   This will hold the Resume data.
   If network fails it will dispaly last fetch data
   **/
  private var resumeDetails : Resume?{
    didSet{
      activityIndicatorDetails.value = (false,"")
      shouldEnableRefresh.value = true
      resume.value = resumeDetails
    }
  }
  
  /* private Error details
   This will hold the Error and activity indicator data.
   **/
  private var errorDetails : ErrorResult?{
    didSet{
      shouldEnableRefresh.value = true
      guard let title = errorDetails?.title, let description = errorDetails?.description else { return }
      activityIndicatorDetails.value = (false,description )
      showAlert.value = SingleButtonAlert(title: title, message: description,
                                          action: AlertAction(buttonTitle: "Ok",
                                                              handler: nil))
    }
  }
  //MARK:- Init Method
  init(_ session: NetworkSession = URLSession.shared) {
    self.networkManager = NetworkManager.init(session: session)
  }
  
  
  func refreshBarButtonTapped(){
    if resumeDetails == nil {
      activityIndicatorDetails.value = (true , "Loading...")
    }
    shouldEnableRefresh.value = false
    fetchResume()
  }
  /* Fetch Data
   * Checking if there is data available in Persistant store
      and is not test case running
   * Otherwise fetch from server
 **/
  func fetchResume()  {
    
    guard !isTestCaseRunning(),
      let data = UserDefaults.standard.resume,
      let decodedResume = try? JSONDecoder().decode(Resume.self, from: data) else {
      fetchFromNetwork()
      return
    }
    resumeDetails = decodedResume
  }
  
  private func fetchFromNetwork(){
    networkManager?.fetchDataFromServer { [weak self] (response) in
      switch response {
      // Handle the failure
      case .failure(let error):
        self?.errorDetails = error
      // Handle success
      case .success(let data):
        self?.resumeDetails = data
      }
    }
  }
}
