//
//  HorizontalInfoListItemTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class HorizontalInfoListItemTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowHorizontalListItem() {
        let sut = HorizontalInfoListItemView(viewModel: getItem())
        addSubviewForTest(sut)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    func testShouldUpdateHorizontalListItem() {
        let sut = HorizontalInfoListItemView(viewModel: getItem())
        addSubviewForTest(sut)

        let newViewModel = HorizontalInfoListViewModel(imageURL: Strings.mockMainDogImageURL.localizable, title: Strings.mockDog.localizable, subtitle: Strings.mockDate.localizable, descriptionText: Strings.mockOverview.localizable)
        sut.update(viewModel: newViewModel)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    // MARK: - Private functions()

    private func getItem() -> HorizontalInfoListViewModel {
        guard let movieResponse: MovieResponse = MocksHelper.getResponse() else {
            return HorizontalInfoListViewModel(imageURL: .empty, title: Strings.mockDog.localizable, subtitle: Strings.mockDate.localizable, descriptionText: Strings.mockOverview.localizable)
        }

        return HorizontalInfoListViewModel(imageURL: Movs.Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), title: movieResponse.title, subtitle: movieResponse.releaseDate, descriptionText: movieResponse.overview)
    }
}
