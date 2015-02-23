//
//  Event.swift
//  SwiftPlaces
//
//  Created by Colin Eberhardt on 27/11/2014.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation


//MARK: - Public API

/// An object that has some tear-down logic
public protocol Disposable {
  func dispose()
}



/// An event provides a mechanism for raising notifications, together with some
/// associated data. Multiple function handlers can be added, with each being invoked,
/// with the event data, when the event is raised.
public class Event {
  
  public typealias EventHandler = () -> ()
  
  private var eventHandlers = [Invocable]()
  
  public init() {
  }
  
  /// Raises the event, invoking all handlers
  public func raise() {
    for handler in self.eventHandlers {
      handler.invoke()
    }
  }
  
  /// Adds the given handler
  public func addHandler<U: AnyObject>(target: U, handler: (U) -> EventHandler) -> Disposable {
    let wrapper = EventHandlerWrapper(target: target, handler: handler, event: self)
    eventHandlers.append(wrapper)
    return wrapper
  }
}

// MARK:- Private

// A protocol for a type that can be invoked
private protocol Invocable: class {
  func invoke()
}

// takes a reference to a handler, as a class method, allowing
// a weak reference to the owning type.
// see: http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/
private class EventHandlerWrapper<T: AnyObject> : Invocable, Disposable {
  weak var target: T?
  let handler: T -> () -> ()
  let event: Event
  
  init(target: T?, handler: T -> () -> (), event: Event){
    self.target = target
    self.handler = handler
    self.event = event;
  }
  
  func invoke() -> () {
    if let t = target {
      handler(t)()
    }
  }
  
  func dispose() {
    event.eventHandlers = event.eventHandlers.filter { $0 !== self }
  }
}


