//
//  MovsIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum MovsIdentifiers: String, AccessibilityIdentifier {

    // MARK: - Movie identifiers

    case moviesTabBarItem = "movies_tab_bar_item"

    // MARK: - Favorites identifiers

    case favoritesTabBarItem = "favorites_tab_bar_item"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        .empty
    }
}
