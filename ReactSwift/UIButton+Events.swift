//
//  UIButton+Events.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 22/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

var key: UInt8 = 0

extension UIButton {
  
  /// An action that is invoked when the button is tapped
  var tappedEvent: Event<Void> {
    get {
      let maybeEvent = objc_getAssociatedObject(self, &key) as Event<Void>?
      if let event = maybeEvent {
        return event
      } else {
        let event = Event<Void>()
        addTarget(self, action: "tapped", forControlEvents: .TouchUpInside)
        objc_setAssociatedObject(self, &key, event, UInt(OBJC_ASSOCIATION_RETAIN))
        return event
      }
    }
  }
  
  func tapped() {
    println("tapped")
    tappedEvent.raise()
  }
  
}
