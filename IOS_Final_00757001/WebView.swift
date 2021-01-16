//
//  WebView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2020/12/28.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string:urlString){
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    typealias UIViewType = WKWebView
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://www.google.com")
    }
}
