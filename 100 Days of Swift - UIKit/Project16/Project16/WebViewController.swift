//
//  WebViewController.swift
//  Project16
//
//  Created by Anvar Rahimov on 15.02.2022.
//

import UIKit
import WebKit

class WebViewController: ViewController {
    var webView: WKWebView!
    var capitalURL: URL?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = capitalURL else { return }
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}
