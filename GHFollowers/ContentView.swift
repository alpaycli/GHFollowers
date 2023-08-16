//
//  ContentView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 13.08.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
