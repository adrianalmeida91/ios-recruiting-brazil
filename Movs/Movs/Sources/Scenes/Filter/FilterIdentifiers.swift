//
//  FilterIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum FilterIdentifiers: String, AccessibilityIdentifier {
    case backButton = "back_button"
    case applyButton = "apply_button"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        "filter"
    }
}
