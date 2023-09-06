//
//  PostListView.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 5/9/23.
//

import SwiftUI

struct PostListView: View {
    @StateObject var vm = PostListViewModel()
    var userId: Int?
    var body: some View {
        List {
            ForEach(vm.posts) { posts in
                VStack(alignment: .leading) {
                    Text(posts.title)
                        .font(.title2)
                    Text(posts.body)
                }
            }
        }
        // overlay puts a view on top of all the views
        .overlay(content: {
            if vm.isLoading {
                ProgressView()
            }
        })
        .alert("Application Alert", isPresented: $vm.showAlert, actions: {
            Button("OK") {}
        }, message: {
            if let message = vm.errorMessage {
                Text(message)
            }
        })
        .navigationTitle("Posts")
        .listStyle(.plain)
        .task {
            if let userId = userId {
                await vm.fetchPosts(userId: userId)
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostListView(userId: 1)
        }
    }
}
