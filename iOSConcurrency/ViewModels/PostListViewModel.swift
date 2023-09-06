//
//  PostListViewModel.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 5/9/23.
//

import Foundation

class PostListViewModel: ObservableObject {
    @Published var posts: [PostViewModel] = []
    var postList: [Post] = []
    // Define the status of the loading bar
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?

    @MainActor
    func fetchPosts(userId: Int) async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            postList = try await apiService.getAPI()
            self.posts = postList.map { PostViewModel(post: $0) }
        } catch {
            self.showAlert = true
            self.errorMessage = error.localizedDescription +
            "\n Please contact the developper and provide him with the error details "
        }
    }
}
