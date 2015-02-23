//
//  ReactView.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

enum ReactView {
  case View(CGRect, [ReactView])
  case Button(CGRect, String, Invocable)
  case Text(CGRect, String)
}

func createView(virtualView: ReactView) -> UIView {
  switch virtualView {
  case .View(let frame, let children):
    let view = UIView(frame: frame)
    for child in children {
      view.addSubview(createView(child))
    }
    return view
    
  case .Button(let frame, let text, let invocable):
    let view = UIButton(frame: frame)
    view.backgroundColor = UIColor.redColor()
    view.setTitle(text, forState: UIControlState.Normal)
    view.tappedEvent.addHandler(invocable)
    return view
    
  case .Text(let frame, let text):
    let view = UITextField(frame: frame)
    view.text = text
    return view
  }
}