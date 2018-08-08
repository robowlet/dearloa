//
//  CartViewController.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/16/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit
import WebKit

class CartViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var cartWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.instagram.com/dear.loa/?hl=en")
        let request = URLRequest(url: url!)
        cartWebView.load(request)
    
}
}
