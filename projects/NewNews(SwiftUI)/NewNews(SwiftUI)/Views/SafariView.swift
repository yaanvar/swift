//
//  SafariView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 15.08.2022.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let viewController = SFSafariViewController(url: url)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }

}
