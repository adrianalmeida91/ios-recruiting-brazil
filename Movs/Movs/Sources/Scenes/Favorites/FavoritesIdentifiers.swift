//
//  FavoritesIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum FavoritesIdentifiers: String, AccessibilityIdentifier {
    case favoritesTabBarItem = "favorites_tab_bar_item"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        "favorites"
    }
}
