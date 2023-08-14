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
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    
    init(username: String) {
        self.username = username
        let manager = NetworkManager()
        _followersFetcher = StateObject(wrappedValue: FollowersFetcher(manager: manager))
    }
    
    private let baseURL = "https://api.github.com/users/"
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(followersFetcher.followers, id: \.self) { item in
                    VStack {
                        AsyncImage(url: URL(string: item.avatarUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }

                        Text(item.login)
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .lineLimit(1)
                            .frame(height: 10)
                    }
                    .padding()
                }
            }
            .task {
                await followersFetcher.fetchFollowers(for: username)
            }
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerListView(username: "SAllen0400")
    }
}
