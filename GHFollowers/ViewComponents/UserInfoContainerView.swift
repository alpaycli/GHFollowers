//
//  UserInfoContainerView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 15.08.23.
//

import SafariServices
import SwiftUI

struct UserInfoContainerView: View {
    let leftSideSFSymbol: Image
    let rightSideSFSymbol: Image
    
    let leftSideText: String
    let rightSideText: String
    
    let leftSideAmount: Int
    let rightSideAmount: Int
    
    let buttonText: String
    let buttonColor: Color
    
    var username: String
    
    @State var isPresentWebView: Bool = false
    @State var isPresentFollowersList: Bool = false
    
    init(leftSideText: String, rightSideText: String, leftSideAmount: Int, rightSideAmount: Int, buttonText: String, buttonColor: Color, leftSideSFSymbol: Image, rightSideSFSymbol: Image, username: String) {
        self.leftSideText = leftSideText
        self.rightSideText = rightSideText
        self.leftSideAmount = leftSideAmount
        self.rightSideAmount = rightSideAmount
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.leftSideSFSymbol = leftSideSFSymbol
        self.rightSideSFSymbol = rightSideSFSymbol
        self.username = username
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    
                    HStack {
                        leftSideSFSymbol
                        Text(leftSideText)
                    }
                    Text("\(leftSideAmount)")
                }
                Spacer()
                VStack {
                    HStack {
                        rightSideSFSymbol
                        Text(rightSideText)
                    }
                    Text("\(rightSideAmount)")
                }
            }
            
            Button(buttonText) {
                if buttonColor == .purple { isPresentWebView = true }
                else {
                    dismiss()
                    
                }
            }
            .fullScreenCover(isPresented: $isPresentWebView) {
                let url = "https://github.com/" + username
                SafariWebView(url: URL(string: url)!)
                    .ignoresSafeArea()
            }
            .frame(width: ScreenSize.width - 80, height: 40)
            .background(buttonColor)
            .cornerRadius(10)
            .foregroundColor(.white)
            
         }
        .padding()
        .frame(width: ScreenSize.width - 40)
        .fontWeight(.bold)
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.05))
        .cornerRadius(10)
        
    }
}

struct UserInfoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoContainerView(leftSideText: "Public Gists", rightSideText: "Public Gists", leftSideAmount: 3, rightSideAmount: 5, buttonText: "Go to Github", buttonColor: .red, leftSideSFSymbol: Image(systemName: "person.2"), rightSideSFSymbol: Image(systemName: "person.2"), username: "sallen0400")
    }
}



struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
