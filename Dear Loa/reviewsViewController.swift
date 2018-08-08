//
//  reviewsViewController.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/17/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit
import WebKit

class reviewsViewController: UIViewController {

    @IBOutlet weak var reviewsWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.etsy.com/shop/DearLoa/reviews")
        let request = URLRequest(url: url!)
        reviewsWebView.load(request)    }


}
