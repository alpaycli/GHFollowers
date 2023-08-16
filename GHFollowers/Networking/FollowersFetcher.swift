//
//  FollowersFetcher.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 13.08.23.
//

import Foundation

@MainActor
class FollowersFetcher: ObservableObject {
    @Published var followers: [Follower] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let manager = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    func fetchFollowers(for username: String) async {
        let endpoint = baseURL + username + "/followers"
        
        guard let url = URL(string: endpoint) else { return }
        
        print(url)
        
        isLoading = true
        Task {
            do {
                let followers = try await manager.fetch([Follower].self, url: url)
                self.followers = followers
                isLoading = false
                errorMessage = nil
            } catch {
                isLoading = false
                errorMessage = "Something went wrong"
                print(error)
            }
        }
    }
}
