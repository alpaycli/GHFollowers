//
//  Follower.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 14.08.23.
//

import Foundation

struct Follower: Codable, Hashable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
}
