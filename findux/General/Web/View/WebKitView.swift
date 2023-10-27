//
//  WebKitView.swift
//  findux
//
//  Created by Péricles Narbal on 27/10/23.
//

import UIKit
import SwiftUI
import WebKit

class WebKitView: BaseView<BaseChildCoordinator<MainCoordinator>> {
    let webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    required init(frame: CGRect = .zero, url: URL) {
        super.init(frame: frame)
        setupView(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(url: URL) {
        addSubview(webView)
        embedConstraints(webView)
        
        loadUrl(url: url)
    }
    
    func loadUrl(url: URL) {
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}
