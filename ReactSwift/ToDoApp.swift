//
//  ToDoApp.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

class ToDoApp: ReactComponent {
  
  var count: Int = 0
  
  func changeNumber(newValue: Int) {
    count = newValue
    renderer.render()
  }
  
  func render() -> ReactView {
    
    return ReactView.View(CGRect(x: 100, y: 100, width: 200, height: 200),
      [
        ReactView.Text(CGRect(x: 50, y: 0, width: 100, height: 50), "\(count)"),
        Toolbar(frame: CGRect(x: 0, y: 50, width: 100, height: 20), count: count, updateFunc: changeNumber)
      ])
    
  }
}

class Toolbar: ReactComponent {
  
  let updateFunc: Int -> ()
  let count: Int
  let frame: CGRect
  
  init(frame: CGRect, count: Int, updateFunc: Int -> ()) {
    self.updateFunc = updateFunc
    self.count = count
    self.frame = frame
  }
  
  func up() {
    updateFunc(count + 1)
  }
  
  func down() {
    updateFunc(count - 1)
  }
  
  func render() -> ReactView {
    let upHandler = EventHandlerWrapper(target: self, handler: Toolbar.up)
    let downHandler = EventHandlerWrapper(target: self, handler: Toolbar.down)
    let halfWidth = frame.width / 2
    
    return ReactView.View(frame,
      [ReactView.Button(CGRect(x: 0, y: 0, width: halfWidth, height: frame.height), "up", upHandler),
      ReactView.Button(CGRect(x: halfWidth, y: 0, width: halfWidth, height: frame.height), "down", downHandler),
    ])
  }
}