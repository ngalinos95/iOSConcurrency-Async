//
//  UserViewModel.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 12/8/23.
//

import Foundation

class UserViewModel: Identifiable, Codable {
    var user: User
    init(user: User) {
        self.user = user
    }
    var id: Int {
        return self.user.id
    }
    var name: String {
        return self.user.name
    }
    var username: String {
        return self.user.username
    }
    var email: String {
        return self.user.email
    }
}
