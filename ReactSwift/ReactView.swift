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
  case TextField(CGRect, String, Invocable)
  
  func render() -> ReactView {
    return self
  }
}

var reactComponents = [ReactComponent]()

func createView(virtualView: ReactView) -> UIView {
  switch virtualView {
  case let .View(frame, children):
    let view = UIView(frame: frame)
    for child in children {
      reactComponents.append(child)
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
    let view = UILabel(frame: frame)
    view.text = text
    return view
    
  case let .TextField(frame, text, invocable):
    let view = UITextField(frame: frame)
    view.text = text
    view.changedEvent.addHandler(invocable)
    return view
  }
}