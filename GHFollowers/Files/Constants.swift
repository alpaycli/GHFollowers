//
//  Constants.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 15.08.23.
//

import SwiftUI

enum SFSymbols {
    static let repos = Image(systemName: "folder")
    static let gists = Image(systemName: "text.alignleft")
    static let followers = Image(systemName: "heart")
    static let following = Image(systemName: "person.2")
    static let location = Image(systemName: "mappin")
}

enum Images {
    static let ghLogo = Image("gh-logo")
    static let placeholder = Image("avatar-placeholder")
    static let emptyStateLogo = Image("empty-state-logo")
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
}
