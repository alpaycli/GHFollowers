//
//  UserInfoView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 15.08.23.
//

import SwiftUI

protocol UserInfoViewDelegate {
    func didTapGetFollowers(for username: String)
}

struct UserInfoView: View {
    private let manager = NetworkManager()
    let username: String
    
    @State private var user: User = User.example
    
    init(username: String, delegate: FollowerListViewDelegate) {
        self.username = username
        self.delegate = delegate
    }
    
    var delegate: FollowerListViewDelegate
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment: .leading) {
                                Text(user.login)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(user.name ?? "")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                
                                Text(user.location ?? "No Location")
                            }
                        }
                        
                        Text(user.bio ?? "No Bio")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 40)
                
                Section {
                    UserInfoContainerView(leftSideText: "Public Gists", rightSideText: "Public Repos", leftSideAmount: user.publicGists, rightSideAmount: user.publicRepos, buttonText: "Go to GitHub", buttonColor: .purple, leftSideSFSymbol: SFSymbols.gists, rightSideSFSymbol: SFSymbols.repos, username: username, delegate: self)
                        .frame(height: 100)
                        .padding(.top, 30)
                    
                    UserInfoContainerView(leftSideText: "Following", rightSideText: "Followers", leftSideAmount: user.following, rightSideAmount: user.followers, buttonText: "Get Followers", buttonColor: .blue, leftSideSFSymbol: SFSymbols.following, rightSideSFSymbol: SFSymbols.followers, username: username, delegate: self)
                        .padding(.vertical, 25)
                }
                
            }
            Group {
                Text("GitHub since ")
                +
                Text(user.createdAt.convertDateToString())
                    .foregroundColor(.secondary)
            }
            .padding(.top)
            
            Spacer()
        }
        .frame(width: ScreenSize.width - 60)
        .task {
            await fetchUser(for: username)
        }
    }
    
    func fetchUser(for username: String) async {
        let baseURL = "https://api.github.com/users/"

        let endpoint = baseURL + username
        
        guard let url = URL(string: endpoint) else { return }
        
        Task {
            do {
                user = try await manager.fetch(User.self, url: url)
            } catch {
                print(error)
            }
        }
    }
}

extension UserInfoView: UserInfoViewDelegate {
    func didTapGetFollowers(for username: String) {
        if user.followers > 0 {
            delegate.isRefreshFollowers(for: username, page: 1)
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(username: "mecid", delegate: self as! FollowerListViewDelegate)
    }
}
