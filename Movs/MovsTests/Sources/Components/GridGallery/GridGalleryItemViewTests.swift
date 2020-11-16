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

    private let loremImage = Strings.mockMainDogImageURL.localizable

    private let titleLoren = Strings.mockDog.localizable

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

        gridGalleryItemViewModel.imageURL = Strings.mockSecondaryDogImageURL.localizable
        gridGalleryItemViewModel.title = Strings.mockOtherDog.localizable
        gridGalleryItemViewModel.isFavorite = true
        sut.update(viewModel: gridGalleryItemViewModel)

        wait(for: Constants.Utils.sleep)

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

        wait(for: Constants.Utils.sleep)

        return sut
    }
}
