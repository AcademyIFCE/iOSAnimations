//
//  ViewController.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainView = MainView(frame: .zero)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Favorites"
    }
}

