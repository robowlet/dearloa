//
//  LaunchViewController.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/11/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        circleView.layer.cornerRadius = circleView.bounds.size.width/2
            circleView.layer.masksToBounds = true
    }

}
