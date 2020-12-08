//
//  TabBarIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum TabBarIdentifiers: String, AccessibilityIdentifier {
    case filterIcon = "filter_icon"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        "tabbar"
    }
}
