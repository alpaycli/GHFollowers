//
//  FavoritesView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 14.08.23.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favorites: [Follower] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if favorites.isEmpty {
                    Text("No favorites")
                } else {
                    List {
                        ForEach(favorites) { item in
                            FavoritesItemView(follower: item)
                        }
                    }
                }
            }
            .onAppear {
                PersistenceManager.shared.loadFavorites(completion: { result in
                    switch result {
                    case .success(let favorites):
                        self.favorites = favorites
                    case .failure(let error):
                        print(error)
                    }
                })
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
