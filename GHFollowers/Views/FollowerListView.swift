//
//  FollowerListView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 14.08.23.
//

import SwiftUI

protocol FollowerListViewDelegate {
    func isRefreshFollowers(for username: String, page: Int)
}

struct FollowerListView: View {
    
    @StateObject private var followersFetcher: FollowersFetcher
    
    @State private var username: String
    @State private var page: Int = 1
    
    @State private var searchText = ""
    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return followersFetcher.followers
        } else {
            return followersFetcher.followers.filter { $0.login.localizedCaseInsensitiveContains(searchText)
            }
        }
        
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @State private var selectedFollower: Follower?
    
    private let manager = NetworkManager()
    init(username: String) {
        self.username = username
        _followersFetcher = StateObject(wrappedValue: FollowersFetcher())
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(filteredFollowers, id: \.self) { item in
                    Button {
                        selectedFollower = item
                    } label: {
                        FollowerItemView(follower: item)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)
                }
                
                ProgressView()
                    .onAppear {
                        guard !filteredFollowers.isEmpty, followersFetcher.hasMoreFollowers, !followersFetcher.isLoading else { return }
                            page += 1
                            Task { await followersFetcher.fetchFollowers(for: username, page: page) }
                        }
            
            }
            .task { await followersFetcher.fetchFollowers(for: username, page: page) }
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addToFavorite) { Image(systemName: "plus") }
                }
            }
            .searchable(text: $searchText)
            .sheet(item: $selectedFollower) { item in
                UserInfoView(username: item.login, delegate: self)
            }
        }
    }
    
    private func addToFavorite() {
        let baseURL = "https://api.github.com/users/"
        let endpoint = baseURL + username
        guard let url = URL(string: endpoint) else { return }
        Task {
            do {
                let user = try await manager.fetch(User.self, url: url)
                let follower = Follower(id: user.id, login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.shared.updateWith(follower, actionType: .add) { error in
                    guard let error = error else {
                        print("succesfully added")
                        return
                    }
                    print(error)
                }
            } catch { print(error) }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}


extension FollowerListView: FollowerListViewDelegate {
    func isRefreshFollowers(for username: String, page: Int) {
        Task {
            guard followersFetcher.hasMoreFollowers, !followersFetcher.isLoading else { return }
            self.page = 1
            await followersFetcher.fetchFollowers(for: username, page: page)
            self.username = username

        }
    }
    
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerListView(username: "SAllen0400")
    }
}
