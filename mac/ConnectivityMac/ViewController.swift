//
//  ViewController.swift
//  ConnectivityMac
//
//  Created by Liu YuanYuan on 2019/7/22.
//  Copyright © 2019 Liu YuanYuan. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, NSWindowDelegate, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    private var isShowingContent = false
    
    private lazy var peerService: PeerService = {
        let s = PeerService()
        
        s.didFindDevice = { [weak self] deviceName in
            guard let self = self else {
                return
            }
            if !self.isShowingContent {
                self.webView.loadHTMLString("<html><body>Found a device \"\(deviceName)\"</body></html>", baseURL: nil)
            }
        }
        s.didReceiveFile = { [weak self] url in
            guard let self = self else {
                return
            }
        }
        s.didReceiveURL = { [weak self] url in
            guard let self = self else {
                return
            }
            self.loadURLContent(url: url)
        }
        
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let wind = self.view.window {
            wind.delegate = self;
        }
        self.webView.navigationDelegate = self

        // Do any additional setup after loading the view.
        peerService.startAdvertising()
        peerService.startListening()
        
        self.webView.loadHTMLString("<html><body>No device connected.</body></html>", baseURL: nil)
    }
    
    func windowWillClose(_ notification: Notification) {
        peerService.stopAdvertising()
        peerService.stopListening()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func bringToFront() {
        NSApp.activate(ignoringOtherApps: true)
        if let screen = NSScreen.main {
            self.view.window?.setFrame(screen.visibleFrame, display: true, animate: true)
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func loadURLContent(url: String) {
        self.isShowingContent = true
        if let url = URL(string: url.trimmingCharacters(in: .whitespacesAndNewlines)) {
            self.webView.load(URLRequest(url: url))
        } else {
            self.webView.loadHTMLString("<html><body></body></html>", baseURL: nil)
        }
        self.bringToFront()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Navigation failed, error: \(error.localizedDescription)")
    }
}

