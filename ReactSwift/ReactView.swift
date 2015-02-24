//
//  ReactView.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

enum ReactView: ReactComponent {
  case View(CGRect, [ReactComponent])
  case Button(CGRect, String, Invocable)
  case Text(CGRect, String)
  
  func render() -> ReactView {
    return self
  }
}

func createView(virtualView: ReactView) -> UIView {
  switch virtualView {
  case let .View(frame, children):
    let view = UIView(frame: frame)
    for child in children {
      view.addSubview(createView(child.render()))
    }
    return view
    
  case let .Button(frame, text, invocable):
    let view = UIButton(frame: frame)
    view.setTitleColor(UIColor.blueColor(), forState: .Normal)
    view.setTitle(text, forState: .Normal)
    view.tappedEvent.addHandler(invocable)
    return view
    
  case let .Text(frame, text):
    let view = UITextField(frame: frame)
    view.text = text
    return view
  }
}