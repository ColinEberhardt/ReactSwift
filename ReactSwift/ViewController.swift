//
//  ViewController.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

var _youCannotSeeMe: ReactViewRenderer!

class ViewController: UIViewController {

  let app = TimerApp();
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _youCannotSeeMe = ReactViewRenderer(hostView: view, component: app)
  }
}

