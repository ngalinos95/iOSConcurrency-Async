//
//  User.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 7/8/23.
//

import Foundation
// source : https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
