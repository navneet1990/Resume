//
//  Result.swift
//  PlasticChallenge
//
//  Created by Navneet Singh on 01/03/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

// Network Result enum
enum Result<T, U: Error> {
    case success(data: T)
    case failure(U)
}

