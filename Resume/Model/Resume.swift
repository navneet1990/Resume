//
//  Resume.swift
//  Resume
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

struct Resume: Codable {
  
  let profile:Profile
  let summary : [String]
  let experience: [Experience]
  let skills: [Skills]
  let languages: [Language]
  let education: [Education]
  
}

struct Profile: Codable {
  
  let name : String
  let title: String
  var image: String?
  let email : String
  let phone: String
  let location : Location
  
  struct Location: Codable {
    let city : String
    let country : String
  }
  
}

struct Experience: Codable {
  
  let company: String
  let position: String
  let location: String
  let startDate: String
  let endDate: String
  let summary : String
  let highlights: [String]
}

struct Skills: Codable {
  let name: String
  let keywords: [String]
}

struct Language : Codable{
  let language: String
  let level: String
  let rating : Int
}

struct Education: Codable {
  let school : String
  let area : String
  let category: String
  let startDate: String
  let endDate: String
  let cgpa: Float
}
