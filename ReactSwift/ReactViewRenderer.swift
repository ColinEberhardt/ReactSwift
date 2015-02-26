//
//  ReactViewRenderer.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

class ReactViewRenderer {
  let hostView: UIView
  let component: ReactComponent
  
  // we need to retain the most recent view, so that any event handlers
  // are retained
  var reactView: ReactView!
  
  init(hostView: UIView, component: ReactComponent) {
    self.hostView = hostView
    self.component = component
    render()
  }
  
  func render() {
    reactView = self.component.render()
    let uiView = createView(reactView);
    
    for subview in hostView.subviews {
      subview.removeFromSuperview()
    }
    self.hostView.addSubview(uiView)
  }
}

// a monsterous hack!
var reactComponents = [ReactComponent]()

func createView(virtualView: ReactView) -> UIView {
  switch virtualView {
  case let .View(frame, children):
    let view = UIView(frame: frame)
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
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
