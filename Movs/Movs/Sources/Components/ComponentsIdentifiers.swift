//
//  ComponentsIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum ComponentsIdentifiers: String, AccessibilityIdentifier {
    case gridGalleryImageView = "grid_gallery_image_view"
    case gridGalleryTitle = "grid_gallery_title"
    case gridGalleryFavoriteImageView = "grid_gallery_favorite_image_view"
    case gridGalleryItemView = "grid_gallery_item_view"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        .empty
    }
}
