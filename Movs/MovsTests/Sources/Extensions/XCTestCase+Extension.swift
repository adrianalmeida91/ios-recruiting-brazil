//
//  XCTestCase+Extension.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

extension XCTestCase {
    var keyWindow: UIWindow? {
        return UIWindow(frame: UIScreen.main.bounds)
//        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }

    func setRootViewController(_ viewController: UIViewController) {
//        let navigationController = UINavigationController(rootViewController: viewController)

        keyWindow?.rootViewController = viewController
        keyWindow?.makeKeyAndVisible()

        viewController.beginAppearanceTransition(true, animated: true)
        viewController.endAppearanceTransition()
    }

    func popRootViewController() {
        keyWindow?.rootViewController?.navigationController?.popToRootViewController(animated: false)
        keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
    }

    func clearRootViewController() {
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
