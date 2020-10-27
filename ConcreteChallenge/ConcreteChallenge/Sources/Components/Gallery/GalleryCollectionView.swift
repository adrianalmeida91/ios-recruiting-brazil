//
//  GalleryCollectionView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryCollectionView: UIView {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

        return collectionView
    }()

    // MARK: - Private constants

    private let collectionViewFlowLayout: UICollectionViewFlowLayout

//    private let dataSource: UICollectionViewDataSource & DataSource = {
//        CollectionViewDataSource<Movie, >
//    }()

    // MARK: - Initializers

    init(flowLayout: UICollectionViewFlowLayout, items: [Movie]) {
        collectionViewFlowLayout = flowLayout

        super.init(frame: .zero)

        setupDataSource(items: items)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private functions

    private func setupDataSource(items: [Movie]) {
    }
}
