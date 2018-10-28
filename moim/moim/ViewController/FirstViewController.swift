//
//  FirstViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import WebKit

class FirstViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://moimweb.herokuapp.com/timeline")
        let request = URLRequest(url: url!)
        webView.load(request)
    }


}

