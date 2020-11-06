//
//  main.swift
//  Movs
//
//  Created by Adrian Almeida on 05/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

private func delegateClassName() -> String? {
  return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClassName())
