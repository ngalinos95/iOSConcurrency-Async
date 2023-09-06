//
//  UserListView.swift
//  iOSConcurrency
//
//  Created by Nikos Galinos, Vodafone on 5/9/23.
//

import SwiftUI

struct UserListView: View {
    @StateObject var vm = UserListViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.users) { users in
                    NavigationLink(value: users.id) {
                        VStack(alignment: .leading) {
                            Text(users.name)
                                .font(.title2)
                            Text(users.email)

                        }
                    }.navigationDestination(for: Int.self) { userId in
                        PostListView(userId: userId)
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
            .navigationTitle("Users")
            .listStyle(.plain)
            .task {
                    await vm.fetchUsers()
            }
        }
    }
}
#if DEBUG
struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
            // Dark Mode Preview
            UserListView().colorScheme(.dark)
            // Light Mode Preview
            UserListView()
    }
}
#endif
