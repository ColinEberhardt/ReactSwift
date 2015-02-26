//
//  TimerApp.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 26/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

let timerFrame = CGRect(x: 100, y: 100, width: 200, height: 35)
let textFrame = CGRect(x: 60, y: 10, width: 100, height: 20)

class TimerApp: NSObject, ReactComponent {
  
  var time = NSDate()
  
  override init() {
    super.init()
    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "tick", userInfo: nil, repeats: true)
  }
  
  func tick() {
    time = NSDate()
    _youCannotSeeMe.render()
  }
  
  func render() -> ReactView {
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "hh:mm:ss"
    
    return ReactView.View(timerFrame,
      [
        ReactView.Text(textFrame, "\(formatter.stringFromDate(time))")
      ])
  }
}