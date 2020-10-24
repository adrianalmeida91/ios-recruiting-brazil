//
//  AppRootController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import class UIKit.UIViewController

protocol AppRootController: AnyObject {
    var rootViewController: UIViewController? { get set }
}
