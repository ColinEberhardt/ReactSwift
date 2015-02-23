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
  
  init(hostView: UIView, component: ReactComponent) {
    self.hostView = hostView
    self.component = component
    render()
  }
  
  func render() {
    let reactView = self.component.render()
    let uiView = createView(reactView);
    
    for subview in hostView.subviews {
      subview.removeFromSuperview()
    }
    self.hostView.addSubview(uiView)
  }
}
