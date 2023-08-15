//
//  User.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 14.08.23.
//

import Foundation

struct User: Codable {
    let login: String
    var name: String?
    var location: String?
    var bio: String?
    let avatarUrl: String
    let htmlUrl: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    
    static let example = User(login: "", avatarUrl: "", htmlUrl: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0, createdAt: Date.now)
}
