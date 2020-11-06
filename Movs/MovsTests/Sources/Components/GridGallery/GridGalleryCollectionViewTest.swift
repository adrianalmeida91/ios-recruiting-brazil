//
//  GridGalleryCollectionViewTest.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class GridGalleryCollectionViewTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = true
    }

    // MARK: - Private constants

    private let itemSize = CGSize(width: 160, height: 200)

    // MARK: - Test functions

    func testShouldShowGalleryCollectionView() {
        let sut = addGridGalleryLayout()

        // TODO - verify why is not working (if call twice verify with wait it's work)
        verify(sut)
    }

    // MARK: - Private functions

    private func addGridGalleryLayout() -> GridGalleryCollectionView {
        let sut = GridGalleryCollectionView(itemSize: itemSize, items: getItems())

        addSubviewForTest(sut) { (viewController: UIViewController) -> [NSLayoutConstraint] in
            [
                sut.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
                sut.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
                sut.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
                sut.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        }

        wait(for: 0)

        return sut
    }

    private func getItems() -> [GridGalleryItemViewModel] {
        if let localData = MocksHelper.readLocalFile(forName: String(describing: MoviesPopulariesResponse.self)),
                let moviesPopulariesResponse: MoviesPopulariesResponse = MocksHelper.parse(jsonData: localData) {

            return moviesPopulariesResponse.moviesResponse.map { movieResponse -> GridGalleryItemViewModel in
                GridGalleryItemViewModel(imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), title: movieResponse.title, isFavorite: false)
            }
        }

        return []
    }
}
