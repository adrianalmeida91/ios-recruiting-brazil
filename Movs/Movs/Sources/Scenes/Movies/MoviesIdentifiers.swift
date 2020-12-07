//
//  MoviesIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum MoviesIdentifiers: String, AccessibilityIdentifier {
    case moviesTabBarItem = "tabbar_item"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        "movies"
    }
}
