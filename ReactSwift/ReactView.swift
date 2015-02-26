//
//  ReactView.swift
//  ReactSwift
//
//  Created by Colin Eberhardt on 21/02/2015.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

import UIKit

enum ReactView: ReactComponent {
  case View(CGRect, [ReactComponent])
  case Button(CGRect, String, Invocable)
  case Text(CGRect, String)
  case TextField(CGRect, String, Invocable)
  
  func render() -> ReactView {
    return self
  }
}
