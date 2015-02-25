//
//  ToDoApp.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

class ToDoApp: ReactComponent {
  
  var items = ["feed the cat", "adopt swift"]
  var newItem = ""
  
  func textChanged(value: String) {
    newItem = value
  }
  
  func addItem() {
    items.append(newItem)
    _youCannotSeeMe.render()
  }
  
  func render() -> ReactView {
    
    let textChangedHandler = EventHandlerWrapper(target: self, handler: ToDoApp.textChanged)
    let addItemHandler = EventHandlerWrapper(target: self, handler: ToDoApp.addItem)
    
    return ReactView.View(CGRect(x: 0, y: 0, width: 300, height: 500),
      [
        ReactView.TextField(CGRect(x: 0, y: 0, width: 200, height: 50), "", textChangedHandler),
        ReactView.Button(CGRect(x: 200, y: 0, width: 100, height: 50), "Add", addItemHandler),
        ListItems(frame: CGRect(x: 0, y: 100, width: 300, height: 500), items: items)
      ])
  }
}

class ListItem: ReactComponent {
  let item: String
  let frame: CGRect
  let deleteAction: () -> ()
  
  init(frame: CGRect, item: String, deleteAction: () -> ()) {
    self.frame = frame
    self.item = item
    self.deleteAction = deleteAction
  }
  
  func deleteItem() {
    deleteAction()
  }
  
  deinit {
    println("I'm gone")
  }
  
  
  func render() -> ReactView {
    
    let addItemHandler = EventHandlerWrapper(target: self, handler: ListItem.deleteItem)
    
    return ReactView.View(frame,
      [
        ReactView.Text(CGRect(x: 0, y: 0, width: 100, height: 50), item),
        ReactView.Button(CGRect(x: 50, y: 0, width: 100, height: 50), "x", addItemHandler)
      ])
  }
}

class ListItems: ReactComponent {
  
  let items: [String]
  let frame: CGRect
  
  init(frame: CGRect, items: [String]) {
    self.frame = frame
    self.items = items
  }
  
  func voi() {
    println("deleted")
  }
  
  deinit {
    println("I'm gone")
  }
  
  func render() -> ReactView {
    var children = [ReactComponent]()
    var offset: CGFloat = 0.0
    for item in items {
      children.append(ListItem(frame: CGRect(x: 0, y: offset, width: frame.width, height: 50), item: item, deleteAction: voi))
      offset += 50
    }
    
    return ReactView.View(frame, children)
  }
}

class CounterApp: ReactComponent {
  
  var count: Int = 0
  
  func changeNumber(newValue: Int) {
    count = newValue
    
    _youCannotSeeMe.render()
  }
  
  func render() -> ReactView {
    
    return ReactView.View(CGRect(x: 100, y: 100, width: 200, height: 200),
      [
        ReactView.Text(CGRect(x: 50, y: 0, width: 100, height: 50), "\(count)"),
        Toolbar(frame: CGRect(x: 0, y: 50, width: 100, height: 20), count: count, updateFunc: changeNumber)
      ])
    
  }
}

class Toolbar: ReactComponent {
  
  let updateFunc: Int -> ()
  let count: Int
  let frame: CGRect
  
  init(frame: CGRect, count: Int, updateFunc: Int -> ()) {
    self.updateFunc = updateFunc
    self.count = count
    self.frame = frame
  }
  
  func up() {
    updateFunc(count + 1)
  }
  
  func down() {
    updateFunc(count - 1)
  }
  
  func render() -> ReactView {
    let upHandler = EventHandlerWrapper(target: self, handler: Toolbar.up)
    let downHandler = EventHandlerWrapper(target: self, handler: Toolbar.down)
    let halfWidth = frame.width / 2
    
    return ReactView.View(frame,
      [ReactView.Button(CGRect(x: 0, y: 0, width: halfWidth, height: frame.height), "up", upHandler),
      ReactView.Button(CGRect(x: halfWidth, y: 0, width: halfWidth, height: frame.height), "down", downHandler),
    ])
  }
}