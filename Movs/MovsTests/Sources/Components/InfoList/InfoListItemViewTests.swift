//
//  InfoListItemViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class InfoListItemViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowInfoListItemCompleted() {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)
        let viewModel = InfoListItemViewModel(title: movieResponse.title, icon: .favoriteEmptyIcon, descriptionText: movieResponse.overview)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowInfoListItemTitleAndIcon() {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)
        let viewModel = InfoListItemViewModel(title: movieResponse.title, icon: .favoriteEmptyIcon)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowInfoListItemTitleAndOverview() {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)
        let viewModel = InfoListItemViewModel(title: movieResponse.title, descriptionText: movieResponse.overview)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowInfoListItemIconAndOverview() {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)
        let viewModel = InfoListItemViewModel(icon: .favoriteFullIcon, descriptionText: movieResponse.overview)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowInfoListItemTitle() {
        let viewModel = InfoListItemViewModel(title: MocksHelper.Dates.y2020.rawValue)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowInfoListItemIcon() {
        let viewModel = InfoListItemViewModel(icon: .favoriteFullIcon)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowInfoListItemOverview() {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)
        let viewModel = InfoListItemViewModel(descriptionText: movieResponse.overview)
        snapshot(viewModel: viewModel)
    }

    func testShouldUpdateInfoListItem() {
        let movieResponse = MovieResponse(path: JSONMocks.movieResponse.rawValue)
        let viewModel = InfoListItemViewModel(title: movieResponse.title, icon: .favoriteEmptyIcon, descriptionText: movieResponse.overview)
        let sut = InfoListItemView(viewModel: viewModel)

        addSubviewForTest(sut)

        let newViewModel = InfoListItemViewModel(title: MocksHelper.Strings.title.rawValue, icon: .favoriteFullIcon, descriptionText: MocksHelper.Strings.overview.rawValue)
        sut.update(viewModel: newViewModel)

        verify(sut)
    }

    // MARK: - Private functions()

    private func snapshot(viewModel: InfoListItemViewModel) {
        let sut = InfoListItemView(viewModel: viewModel)
        addSubviewForTest(sut)

        verify(sut)
    }
}
