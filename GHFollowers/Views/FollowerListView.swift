//
//  FollowerListView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 14.08.23.
//

import SwiftUI

struct FollowerListView: View {
    
    @StateObject private var followersFetcher: FollowersFetcher
    
    let username: String
    
    @State private var searchText = ""
    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return followersFetcher.followers
        } else {
            return followersFetcher.followers.filter { $0.login.localizedCaseInsensitiveContains(searchText)
            }
        }
        
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @State private var selectedFollower: Follower?
    
    private let manager = NetworkManager()
    init(username: String) {
        self.username = username
        _followersFetcher = StateObject(wrappedValue: FollowersFetcher())
    }
    
    private let baseURL = "https://api.github.com/users/"
    
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
            }
            .task {
                await followersFetcher.fetchFollowers(for: username)
            }
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText)
            .sheet(item: $selectedFollower) { item in
                UserInfoView(username: item.login)
            }
        }
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerListView(username: "SAllen0400")
    }
}
