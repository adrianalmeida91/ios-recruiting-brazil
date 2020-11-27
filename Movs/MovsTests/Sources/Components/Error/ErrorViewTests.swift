//
//  ErrorViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 02/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class ErrorViewTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowErroView() {
        let sut = addErrorViewOnViewController()

        verify(sut)
    }

    func testShouldShowErrorViewWithOtherIcon() throws {
        let sut = addErrorViewOnViewController()
        let favoriteFullIconImage = try XCTUnwrap(UIImage(assets: .favoriteFullIcon))
        sut.image = favoriteFullIconImage

        verify(sut)
    }

    func testShouldShowErrorViewWithOtherText() {
        let sut = addErrorViewOnViewController()
        sut.text = "Server error"

        verify(sut)
    }

    func testShouldShowErrorViewWithConfiguration() {
        let searchImage = UIImage(assets: .searchIcon)
        let errorMessage = "Communication error"
        let configuration = ErrorConfiguration(image: searchImage, text: errorMessage)
        let sut = addErrorViewOnViewController(configuration: configuration)

        verify(sut)
    }

    func testShouldShowErrorViewChangeConfiguration() {
        let sut = addErrorViewOnViewController()
        let searchImage = UIImage(assets: .favoriteEmptyIcon)
        let errorMessage = "New communication error"
        let configuration = ErrorConfiguration(image: searchImage, text: errorMessage)
        sut.configuration = configuration

        verify(sut)
    }

    func testShouldErroViewByFactoryMakeIsHidden() {
        let sut = ErrorViewFactory.make()
        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }

    // MARK: - Private functions

    @discardableResult
    private func addErrorViewOnViewController(configuration: ErrorConfiguration = ErrorConfiguration()) -> ErrorView {
        let sut = ErrorView(configuration: configuration)
        addSubviewForTest(equalConstraintsFor: sut)

        return sut
    }
}
