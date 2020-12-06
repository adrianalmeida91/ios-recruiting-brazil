//
//  HorizontalInfoListTableViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class HorizontalInfoListTableViewTests: FBSnapshotTestCase {
    private lazy var items: [HorizontalInfoListViewModel] = {
        let moviesPopulariesResponse = MoviesPopulariesResponse(path: JSONMocks.moviesPopulariesResponse.rawValue)

        return moviesPopulariesResponse.moviesResponse.map { movieResponse -> HorizontalInfoListViewModel in
            HorizontalInfoListViewModel(imageURL: .empty, title: movieResponse.title, subtitle: movieResponse.releaseDate, descriptionText: movieResponse.overview)
        }
    }()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowHorizontalInfoListTableView() {
        let sut = HorizontalInfoListTableView()
        sut.setupDataSource(items: items)

        addHorizontalInfoListTableViewLayout(horizontalInfoTableView: sut)

        verify(sut)
    }

    func testShouldUpdateHorizontalInfoListTableView() {
        let sut = HorizontalInfoListTableView()
        sut.setupDataSource(items: items)

        let sutViewController = addHorizontalInfoListTableViewLayout(horizontalInfoTableView: sut)

        let newItems: [HorizontalInfoListViewModel] = items.reversed()
        sut.setupDataSource(items: newItems)

        sutViewController.view.layoutIfNeeded()

        verify(sut)
    }

    func testShouldCreateHorizontalInfoListTableViewByFactory() {
        let sut = HorizontalInfoListFactory.make()
        sut.setupDataSource(items: items)

        addHorizontalInfoListTableViewLayout(horizontalInfoTableView: sut)

        verify(sut)
    }

    // MARK: - Private functions

    @discardableResult
    private func addHorizontalInfoListTableViewLayout(horizontalInfoTableView: HorizontalInfoListTableView) -> UIViewController {
        let sutViewController = addSubviewForTest(horizontalInfoTableView) { (viewController: UIViewController) -> [NSLayoutConstraint] in
            [
                horizontalInfoTableView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
                horizontalInfoTableView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
                horizontalInfoTableView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
                horizontalInfoTableView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        }

        sutViewController.view.layoutIfNeeded()

        return sutViewController
    }
}
