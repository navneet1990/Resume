//
//  ErrorResult.swift
//  PlasticChallenge
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet. All rights reserved.
//

import Foundation

// Error enum
enum ErrorResult: Error {
    case invalidUrl
    case networkUnavailable
    case invalidDataFormat
 }

extension ErrorResult: LocalizedError {
    public var description: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Could not create a URL", comment: "")
        case .networkUnavailable:
            return NSLocalizedString("Check your network connection", comment: "")
        case .invalidDataFormat:
            return NSLocalizedString("Could not digest the fetched data", comment: "")
        }
    }
  public var title: String?{
    switch self {
    case .invalidUrl:
      return NSLocalizedString("Invalid Url", comment: "")
    case .networkUnavailable:
      return NSLocalizedString("Network", comment: "")
    case .invalidDataFormat:
      return NSLocalizedString("Invalid Data", comment: "")
    }
  }
}
