//
//  LoginViewController.swift
//  GrinnellDB
//
//  Created by Zixuan on 3/14/20.
//  Copyright © 2020 Zixuan. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {

    var webview: WKWebView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview = WKWebView(frame: self.view.frame)
        webview.navigationDelegate = self
        
        view.addSubview(webview)
        
        let url = URL(string: "https://itwebapps.grinnell.edu/Private/asp/campusdirectory/GcDefault.asp")!
        let request = URLRequest(url: url)
        
        webview.load(request)
    }
    
    /* check if we retrieve cookie */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let dataStore = WKWebsiteDataStore.default()
        
        dataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.name == ".AspNet.Cookies" {
                    self.defaults.set(cookie.value, forKey: "cookie")
                    dataStore.httpCookieStore.delete(cookie, completionHandler: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
        }
    }
}
