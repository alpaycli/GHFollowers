//
//  SafariView.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 16.08.23.
//

import SafariServices
import SwiftUI

struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
