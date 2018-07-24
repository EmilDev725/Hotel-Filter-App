//
//  WeddingBlogViewController.swift
//  Swooned
//
//  Created by iDev on 24/07/2018.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit
import WebKit

class WeddingBlogViewController: PSUIViewController, WKNavigationDelegate {

    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    let reviewViewModel = ReviewViewModel()
    
    // MARK: Override Functions
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.selectedMenuIndex = 1

        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.weddingBlogTitle
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        loadWebView()
    }
    
    func loadWebView() {
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        let url = URL(string: "http://www.marryusapp.com/")!
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "loading") {
            backButton.isEnabled = webView.canGoBack
            forwardButton.isEnabled = webView.canGoForward
        }
        
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    @IBAction func click_btn_Back(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func click_btn_Forward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}
