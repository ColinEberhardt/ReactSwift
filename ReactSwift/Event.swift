//
//  Event.swift
//  SwiftPlaces
//
//  Created by Colin Eberhardt on 27/11/2014.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

class Event<T> {
  
  typealias EventHandler = T -> ()
  
  private var eventHandlers = [Invocable]()
  
  init() {
  }
  
  /// Raises the event, invoking all handlers
  func raise(data: T) {
    for handler in self.eventHandlers {
      handler.invoke(data)
    }
  }
  
  
  func addHandler(invocable: Invocable) {
    eventHandlers.append(invocable)
  }
}

public protocol Invocable: class {
  func invoke(data: Any)
}

// takes a reference to a handler, as a class method, allowing
// a weak reference to the owning type.
// see: http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/
public class EventHandlerWrapper<T: AnyObject, U> : Invocable {
  weak var target: T?
  let handler: T -> U -> ()
  
  init(target: T?, handler: T -> U -> ()){
    self.target = target
    self.handler = handler
  }
  
  public func invoke(data: Any) -> () {
    if let t = target {
      handler(t)(data as U)
    }
  }
  
}


