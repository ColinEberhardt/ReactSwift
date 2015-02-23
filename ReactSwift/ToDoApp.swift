//
//  ToDoApp.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

class ToDoApp: ReactComponent {
  
  var count = 0
  
  func tapped() {
    count++
    renderer.render()
  }
  
  func render() -> ReactView {
    
    let eventHandler = EventHandlerWrapper(target: self, handler: ToDoApp.tapped)
    
    return .View(CGRect(x: 0, y: 0, width: 100, height: 200),
      [
        .Text(CGRect(x: 0, y: 0, width: 100, height: 50), "\(count)"),
        .Button(CGRect(x: 0, y: 50, width: 100, height: 50), "foo", eventHandler)
      ])
    
  }
}