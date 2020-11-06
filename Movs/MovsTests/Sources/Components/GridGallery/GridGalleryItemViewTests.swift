//
//  GridGalleryItemViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class GridGalleryItemViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Private constants

    private let loremImage = "https://picsum.photos/id/237/200/300"

    private let titleLoren = "Dog"

    private let itemSize = CGSize(width: 160, height: 200)

    // MARK: - Test functions

    func testShouldShowGalleryItem() {
        let gridGalleryItemViewModel = GridGalleryItemViewModel(imageURL: loremImage, title: titleLoren, isFavorite: false)
        let sut = addGalleryItemOnViewController(viewModel: gridGalleryItemViewModel)

        verify(sut)
    }

    func testShouldUpdateViewModelOnGalleryItem() {
        var gridGalleryItemViewModel = GridGalleryItemViewModel(imageURL: loremImage, title: titleLoren, isFavorite: false)
        let sut = addGalleryItemOnViewController(viewModel: gridGalleryItemViewModel)

        gridGalleryItemViewModel.imageURL = "https://i.picsum.photos/id/1025/4951/3301.jpg?hmac=_aGh5AtoOChip_iaMo8ZvvytfEojcgqbCH7dzaz-H8Y"
        gridGalleryItemViewModel.title = "Other Dog"
        gridGalleryItemViewModel.isFavorite = true
        sut.update(viewModel: gridGalleryItemViewModel)

        // TODO - download image and cache (wait 1 second to download image)
        wait(for: 1)

        verify(sut)
    }

    // MARK: - Private functions

    private func addGalleryItemOnViewController(viewModel: GridGalleryItemViewModel) -> GridGalleryItemView {
        let sut = GridGalleryItemView(viewModel: viewModel)

        addSubviewForTest(sut) { (viewController: UIViewController) -> [NSLayoutConstraint] in
            [
                sut.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 24),
                sut.widthAnchor.constraint(equalToConstant: itemSize.width),
                sut.heightAnchor.constraint(equalToConstant: itemSize.height)
            ]
        }

        // TODO - download image and cache (wait 1 second to download image)
        wait(for: 1)

        return sut
    }
}
