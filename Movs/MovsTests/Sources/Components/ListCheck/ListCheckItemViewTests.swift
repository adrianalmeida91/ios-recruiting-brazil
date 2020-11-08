//
//  ListCheckItemViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class ListCheckItemViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldNotShowListCheckItemEmpty() {
        let viewModel = ListCheckItemViewModel()
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItem() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable, value: Strings.mockDate.localizable, icon: .checkIcon)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItemWithTitle() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItemWithValue() {
        let viewModel = ListCheckItemViewModel(value: Strings.mockDate.localizable)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItemWithIcon() {
        let viewModel = ListCheckItemViewModel(icon: .checkIcon)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItemWithTitleAndValue() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable, value: Strings.mockGenres.localizable)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItemWithTitleAndIcon() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable, icon: .arrowForward)
        snapshot(viewModel: viewModel)
    }

    func testShouldShowListCheckItemWithValueAndIcon() {
        let viewModel = ListCheckItemViewModel(value: Strings.mockDate.localizable, icon: .arrowForward)
        snapshot(viewModel: viewModel)
    }

    func testShouldUpdateListCheckItem() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable, value: Strings.mockDate.localizable, icon: .checkIcon)
        let sut = ListCheckItemView(viewModel: viewModel)

        addSubviewForTest(equalConstraintsFor: sut)

        let newViewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable)
        sut.update(viewModel: newViewModel)

        verify(sut)
    }

    // MARK: - Private functions

    private func snapshot(viewModel: ListCheckItemViewModel) {
        let sut = ListCheckItemView(viewModel: viewModel)
        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }
}
