//
//  ViewController.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

var renderer: ReactViewRenderer!

class ViewController: UIViewController {

  let app = ToDoApp();
  var timer: NSTimer!
  var displayLink: CADisplayLink!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    renderer = ReactViewRenderer(hostView: view, component: app)
  }
}

