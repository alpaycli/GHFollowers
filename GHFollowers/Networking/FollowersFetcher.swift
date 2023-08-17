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
    @Published var errorMessage: String?
    
    @Published var isLoading = false
    @Published var hasMoreFollowers = true
    
    private let manager = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    func fetchFollowers(for username: String, page: Int) async {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else { return }
        
        print(url)
        
        isLoading = true
        Task {
            do {
                let followers = try await manager.fetch([Follower].self, url: url)
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
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
