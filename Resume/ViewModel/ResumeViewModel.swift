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
     * This will hold the Error and activity indicator data.
     * Read data from offline store, if available
     **/
    private var errorDetails : ErrorResult?{
        didSet{
            // Display error
            shouldEnableRefresh.value = true
            guard let title = errorDetails?.title,
                let description = errorDetails?.description else { return }
            showAlert.value = SingleButtonAlert(title: title, message: description,
                                                action: AlertAction(buttonTitle: "Ok",
                                                                    handler: nil))
            
            // Check if offline data is available
            guard let offlineResume = fetchOfflineResume() else{
                activityIndicatorDetails.value = (false,description )
                return
            }
            resumeDetails = offlineResume
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
     * It will always fetch from server if network is available
     **/
    func fetchResume()  {
        
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
    
    /* Offline Resume
     * Checking if there is data available in  private object
     * Otherwise, it will check if there is data available in Persistant store
     and is not test case running
     **/
    private func fetchOfflineResume()-> Resume?{
        
        if let details = resumeDetails{
            return details
        }
        guard !isTestCaseRunning(),
            let data = UserDefaults.standard.resume,
            let decodedResume = try? JSONDecoder().decode(Resume.self, from: data) else {
                return nil
        }
        return decodedResume
    }
}
