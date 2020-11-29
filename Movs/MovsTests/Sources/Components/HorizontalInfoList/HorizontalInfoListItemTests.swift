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
    private lazy var items: HorizontalInfoListViewModel = {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)

        return HorizontalInfoListViewModel(imageURL: .empty, title: movieResponse.title, subtitle: movieResponse.releaseDate, descriptionText: movieResponse.overview)
    }()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowHorizontalListItem() {
        let sut = HorizontalInfoListItemView(viewModel: items)
        addSubviewForTest(sut)

        verify(sut)
    }

    func testShouldUpdateHorizontalListItem() {
        let sut = HorizontalInfoListItemView(viewModel: items)
        addSubviewForTest(sut)

        let newViewModel = HorizontalInfoListViewModel(imageURL: .empty, title: MocksHelper.Strings.title.rawValue, subtitle: MocksHelper.Dates.y2020.rawValue, descriptionText: MocksHelper.Strings.overview.rawValue)
        sut.update(viewModel: newViewModel)

        verify(sut)
    }
}
