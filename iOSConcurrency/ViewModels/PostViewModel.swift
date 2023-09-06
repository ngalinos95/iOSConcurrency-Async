//
//  PostViewModel.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 13/8/23.
//

import Foundation

class PostViewModel: Identifiable, Codable {
    var post: Post
    init(post: Post) {
        self.post = post
    }
    var userId: Int {
        return self.post.userId
    }
    var id: Int {
        return self.post.id
    }
    var title: String {
        return self.post.title
    }
    var body: String {
        return self.post.body
    }
}
