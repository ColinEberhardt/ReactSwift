//
//  ToDoApp.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 25/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

class ToDoApp: ReactComponent {
  
  var items = ["feed the cat", "adopt swift"]
  var newItem = ""
  
  func textChanged(value: String) {
    newItem = value
  }
  
  func itemDeleted(index: Int) {
    items.removeAtIndex(index)
    _youCannotSeeMe.render()
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
        ListItems(frame: CGRect(x: 0, y: 100, width: 300, height: 500), items: items, deleteAction: itemDeleted)
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
  let deleteAction: (Int) -> ()
  
  init(frame: CGRect, items: [String], deleteAction: (Int) -> ()) {
    self.frame = frame
    self.items = items
    self.deleteAction = deleteAction
  }
  
  func voi() {
    println("deleted")
  }
  
  func render() -> ReactView {
    var children = [ReactComponent]()
    var offset: CGFloat = 0.0
    for item in enumerate(items) {
      children.append(ListItem(frame: CGRect(x: 0, y: offset, width: frame.width, height: 50), item: item.element) {
        self.deleteAction(item.index)
        })
      offset += 50
    }
    
    return ReactView.View(frame, children)
  }
}