//
//  FBSnapshotTestCase+Extension.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Movs
import FBSnapshotTestCase

extension FBSnapshotTestCase {
    func verify<T: UIViewController>(_ viewController: T, identifier: String = .empty, tolerance: CGFloat = 0) {
        verify(viewController.view, identifier: identifier, tolerance: tolerance)
    }

    func verify<T: UIView>(_ view: T, identifier: String = .empty, tolerance: CGFloat = 0) {
        FBSnapshotVerifyView(view, identifier: identifier, suffixes: .suffixes, overallTolerance: tolerance)
        FBSnapshotVerifyLayer(view.layer, identifier: identifier, suffixes: .suffixes, overallTolerance: tolerance)
    }

    // MARK: - ViewCode functions

    @discardableResult
    func addSubviewForTest<T: UIView>(_ view: T) -> UIViewController {
        addSubviewForTest(view, constraints: { viewController in [
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
        ]})
    }

    @discardableResult
    func addSubviewForTest<T: UIView>(equalConstraintsFor view: T) -> UIViewController {
        addSubviewForTest(view, constraints: { viewController in [
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ]})
    }

    @discardableResult
    func addSubviewForTest<T: UIView>(_ view: T, constraints: (UIViewController) -> [NSLayoutConstraint]) -> UIViewController {
        let viewController = UIViewController(nibName: nil, bundle: nil)

        viewController.view.addSubview(view, constraints: constraints(viewController))
        viewController.beginAppearanceTransition(true, animated: true)
        viewController.endAppearanceTransition()

        return viewController
    }
}

// MARK: - Private extension

private extension NSOrderedSet {
    static let suffixes = NSOrderedSet(array: [String.empty])
}
