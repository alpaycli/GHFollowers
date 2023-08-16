//
//  SearchView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 13.08.23.
//

import UIKit
import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    
    var maxWidth = UIScreen.main.bounds.size.width
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Images.ghLogo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 40)
            
                
                TextField("Enter a username", text: $username)
                    .frame(width: maxWidth - 100)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                
                
                Spacer()
                Spacer()
                Spacer()
                
                NavigationLink(destination: FollowerListView(username: username)) {
                    Text("Get Followers")
                        .frame(width: maxWidth - 100, height: 50)
                        .background(.green)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
