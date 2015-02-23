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
    return ReactBaseView(frame: CGRect(x: 0, y: 0, width: 100, height: 200), children:
      [ReactButtonView(frame: CGRect(x: 0, y: 50, width: 100, height: 50),
        text: "foo",
        target: self,
        handler: ToDoApp.tapped),
       ReactTextView(frame: CGRect(x: 0, y: 0, width: 100, height: 50), text: "\(count)")]);
    
  }
}