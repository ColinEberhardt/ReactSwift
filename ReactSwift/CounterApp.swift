//
//  ToDoApp.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

let outerFrame = CGRect(x: 100, y: 100, width: 200, height: 200)
let countFrame = CGRect(x: 50, y: 0, width: 100, height: 50)
let spinControlFrame = CGRect(x: 0, y: 50, width: 100, height: 20)
let upButtonFrame = CGRect(x: 50, y: 0, width: 50, height: 20)
let downButtonFrame = CGRect(x: 0, y: 0, width: 50, height: 20)

class CounterApp: ReactComponent {
  
  var count: Int = 0
  
  func changeNumber(newValue: Int) {
    count = newValue
    
    _youCannotSeeMe.render()
  }
  
  func render() -> ReactView {
    return ReactView.View(outerFrame,
      [
        ReactView.Text(countFrame, "\(count)"),
        Toolbar(frame: spinControlFrame, count: count, updateFunc: changeNumber)
      ])
  }
}

struct Toolbar: ReactComponent {
  
  let frame: CGRect
  let count: Int
  let updateFunc: Int -> ()
  
  func up() {
    updateFunc(count + 1)
  }
  
  func down() {
    updateFunc(count - 1)
  }
  
  func render() -> ReactView {
    let upHandler = EventHandlerWrapper(target: self, handler: Toolbar.up)
    let downHandler = EventHandlerWrapper(target: self, handler: Toolbar.down)
    
    return ReactView.View(frame,
      [ReactView.Button(upButtonFrame, "up", upHandler),
      ReactView.Button(downButtonFrame, "down", downHandler),
    ])
  }
}