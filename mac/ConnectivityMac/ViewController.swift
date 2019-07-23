//
//  ViewController.swift
//  ConnectivityMac
//
//  Created by Liu YuanYuan on 2019/7/22.
//  Copyright © 2019 Liu YuanYuan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {
    private var isInDemoMode: Bool {
        return UserDefaults.standard.bool(forKey: "DemoMode")
    }
    
    private lazy var peerService: PeerService = {
        let s = PeerService()
        
        s.didFindDevice = { [weak self] deviceName in
            print("found device ", deviceName)
        }
        s.didReceiveFile = { [weak self] url in
        }
        s.didReceiveURL = { [weak self] url in
        }
        
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.delegate = self

        // Do any additional setup after loading the view.
        peerService.startAdvertising()
        peerService.startListening()
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
}

