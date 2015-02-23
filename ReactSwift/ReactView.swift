//
//  ReactView.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

protocol ReactView {
  var frame: CGRect { get }
  func createView() -> UIView
}

struct ReactBaseView: ReactView {
  let children: [ReactView]
  let frame: CGRect
  
  init(frame: CGRect, children: [ReactView]) {
    self.children = children
    self.frame = frame
  }
  
  func createView() -> UIView {
    let view = UIView(frame: frame)
    for child in children {
      view.addSubview(child.createView())
    }
    return view
  }
}

struct ReactTextView: ReactView {
  let text: String
  let frame: CGRect
  
  init(frame: CGRect, text: String) {
    self.text = text
    self.frame = frame
  }
  
  func createView() -> UIView {
    let view = UITextField(frame: frame)
    view.text = text
    return view
  }
}


struct ReactButtonView<U: AnyObject>: ReactView {
  let text: String
  let frame: CGRect
  let target: U
  let handler: U -> () -> ()
  
  init(frame: CGRect, text: String, target: U, handler: U -> () -> ()) {
    self.text = text
    self.frame = frame
    self.target = target
    self.handler = handler
  }
  
  func createView() -> UIView {
    let view = UIButton(frame: frame)
    view.backgroundColor = UIColor.redColor()
    view.setTitle(text, forState: UIControlState.Normal)
    view.tappedEvent.addHandler(target, handler)
    return view
  }
}
