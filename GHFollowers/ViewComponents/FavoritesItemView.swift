//
//  FavoritesItemView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 16.08.23.
//

import SwiftUI

struct FavoritesItemView: View {
    @StateObject var imageLoader: ImageLoader
    let follower: Follower
    
    init(follower: Follower) {
        self.follower = follower
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString: follower.avatarUrl))
    }
    var body: some View {
        HStack {
            Image(uiImage: imageLoader.image)
                .resizable()
                .scaledToFit()
                .clipped()
                .cornerRadius(10)
                .frame(width: 60, height: 60)
            
            Text(follower.login)
                .multilineTextAlignment(.leading)
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading, 10)
        }
    }
}

struct FavoritesItemView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesItemView(follower: Follower(id: 0, login: "", avatarUrl: ""))
    }
}
