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
    var relogin: Bool = false
    
    
    let defaults = UserDefaults.standard
    
    func alertAndDismiss(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview = WKWebView(frame: self.view.frame)
        webview.navigationDelegate = self
        
        view.addSubview(webview)
        
        let url = URL(string: "https://itwebapps.grinnell.edu/Private/asp/campusdirectory/GcDefault.asp")!
        let request = URLRequest(url: url)
        if relogin {
            removeCookies()
            relogin = false
        }
        webview.load(request)
    }
    
    func removeCookies(){
        let dataStore = WKWebsiteDataStore.default()
        dataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                print("COOKIE \(cookie)")
                dataStore.httpCookieStore.delete(cookie, completionHandler: nil)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("ERROR\(error)")
        alertAndDismiss(title: "HTTP Loading Error", message: error.localizedDescription)
    }
    
    /* check if we retrieve cookie */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.name == ".AspNet.Cookies" {
                    self.defaults.set(cookie.value, forKey: "cookie")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
