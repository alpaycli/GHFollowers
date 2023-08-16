//
//  FollowerItemView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 16.08.23.
//

import SwiftUI

struct FollowerItemView: View {
    @StateObject var imageLoader: ImageLoader
    let follower: Follower
    
    init(follower: Follower) {
        self.follower = follower
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString: follower.avatarUrl))
    }
    
    @State private var avatar = UIImage()
    var body: some View {
        VStack {
            Image(uiImage: imageLoader.image)
                .resizable()
                .scaledToFit()
                .clipped()
                .cornerRadius(10)
                .frame(width: 100, height: 100)
            
            Text(follower.login)
        }
       
    }
}

struct FollowerItemView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerItemView(follower: Follower.init(id: 0, login: "", avatarUrl: ""))
    }
}
