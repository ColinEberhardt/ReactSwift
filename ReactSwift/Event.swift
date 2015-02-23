//
//  Event.swift
//  SwiftPlaces
//
//  Created by Colin Eberhardt on 27/11/2014.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

class Event {
  
  typealias EventHandler = () -> ()
  
  private var eventHandlers = [Invocable]()
  
  init() {
  }
  
  /// Raises the event, invoking all handlers
  func raise() {
    for handler in self.eventHandlers {
      handler.invoke()
    }
  }
  
  
  func addHandler(invocable: Invocable) {
    eventHandlers.append(invocable)
  }
}

public protocol Invocable: class {
  func invoke()
}

// takes a reference to a handler, as a class method, allowing
// a weak reference to the owning type.
// see: http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/
public class EventHandlerWrapper<T: AnyObject> : Invocable {
  weak var target: T?
  let handler: T -> () -> ()
  
  init(target: T?, handler: T -> () -> ()){
    self.target = target
    self.handler = handler
  }
  
  public func invoke() -> () {
    if let t = target {
      handler(t)()
    }
  }
  
}


