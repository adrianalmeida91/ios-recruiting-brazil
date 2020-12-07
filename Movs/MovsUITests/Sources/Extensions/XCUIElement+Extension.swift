//
//  XCUIElement+Extension.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

extension XCUIElement {
    func clearText() {
        guard let string = value as? String else {
            return
        }

        tap()

        let delete = String(repeating: XCUIKeyboardKey.delete.rawValue, count: string.count)
        typeText(delete)
    }
}
