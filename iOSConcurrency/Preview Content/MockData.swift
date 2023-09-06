//
//  MockData.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 14/8/23.
//

import Foundation
// we create a struct with our mockData
// this is a test mockData using the bundle extension and the decode function in
// order to get data from the local .json files we created on the Preview Content
struct  MockData {
    var mockUsers: [User] {
       return Bundle.main.decode([User].self, from: "users.json")
    }
}
