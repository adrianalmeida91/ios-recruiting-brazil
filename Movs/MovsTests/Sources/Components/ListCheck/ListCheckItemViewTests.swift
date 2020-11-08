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

    func testShouldShowListCheckItem() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable, value: Strings.mockDate.localizable, icon: .checkIcon)
        let sut = ListCheckItemView(viewModel: viewModel)

        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }

    func testShouldUpdateListCheckItem() {
        let viewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable, value: Strings.mockDate.localizable, icon: .checkIcon)
        let sut = ListCheckItemView(viewModel: viewModel)

        addSubviewForTest(equalConstraintsFor: sut)

        let newViewModel = ListCheckItemViewModel(title: Strings.mockDog.localizable)
        sut.update(viewModel: newViewModel)

        verify(sut)
    }

    func testShouldShowListCheckItemWithoutTitle() {
        let viewModel = ListCheckItemViewModel(value: Strings.mockDate.localizable, icon: .arrowForward)
        let sut = ListCheckItemView(viewModel: viewModel)

        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }
}
