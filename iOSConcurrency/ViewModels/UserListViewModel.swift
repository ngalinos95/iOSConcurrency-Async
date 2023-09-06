//
//  UserListViewModel.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 5/9/23.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [UserViewModel] = []
    var userList: [User] = []
    // Define the status of the loading bar
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?

    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            // userList defines the T Decodabel we want to use
            // in this case the T: Decodable is the User
            userList = try await apiService.getAPI()
            // then we parse the user 
            self.users = userList.map { UserViewModel(user: $0) }
        } catch {
            self.showAlert = true
            self.errorMessage = error.localizedDescription +
            "\n Please contact the developper and provide him with the error details "
        }
    }
}
