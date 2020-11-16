//
//  XCTestCase+Extension.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

extension XCTestCase {
    func setRootViewController(_ viewController: UIViewController) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.rootViewController = viewController
        keyWindow?.makeKeyAndVisible()

        viewController.beginAppearanceTransition(true, animated: true)
        viewController.endAppearanceTransition()
    }

    func popRootViewController() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.rootViewController?.navigationController?.popToRootViewController(animated: false)
        keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
    }

    func clearRootViewController() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.rootViewController = UINavigationController(
            rootViewController: UIViewController()
        )
    }

    func wait(for duration: TimeInterval = 0) {
        let waitExpectation = expectation(description: "Waiting")

        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }

        waitForExpectations(timeout: duration + 1)
    }
}
