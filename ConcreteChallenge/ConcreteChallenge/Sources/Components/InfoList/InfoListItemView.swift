//
//  InfoListItemView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class InfoListItemView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)

        return label
    }()

    private lazy var iconButton: UIButton = {
        let button = UIButton()

        return button
    }()

    private lazy var titleButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, iconButton])

        return stackView
    }()

    private lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0

        return label
    }()

    private lazy var stackDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleButtonStackView, descriptionText])
        stackView.axis = .vertical
        stackView.spacing = 4

        return stackView
    }()

    // MARK: - Private constants

    private var viewModel: InfoListItemViewModel {
        didSet {
            setupViewModel()
        }
    }

    private var buttonTapped: (() -> Void)?

    // MARK: - Initializers

    init(viewModel: InfoListItemViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Functions

    func update(viewModel new: InfoListItemViewModel) {
        viewModel = new
    }

    func bind(_ handler: @escaping () -> Void) {
        buttonTapped = handler
    }

    // MARK: - Private functions

    private func setup() {
        setupLayout()
        setupViewModel()
        setupActions()
    }

    private func setupLayout() {
        addSubview(stackDescriptionStackView, constraints: [
            stackDescriptionStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackDescriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackDescriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackDescriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    private func setupViewModel() {
        if viewModel.title == nil, viewModel.icon == nil {
            titleButtonStackView.isHidden = true
        } else {
            titleButtonStackView.isHidden = false

            if let titleText = viewModel.title {
                title.isHidden = false
                title.text = titleText
            } else {
                title.isHidden = true
            }

            if let icon = viewModel.icon {
                let image = UIImage(assets: icon)?.withInsets(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
                iconButton.isHidden = false
                iconButton.setImage(image, for: .normal)
            } else {
                iconButton.isHidden = true
            }
        }

        if let descriptionText = viewModel.descriptionText {
            self.descriptionText.isHidden = false
            self.descriptionText.text = descriptionText
        } else {
            descriptionText.isHidden = true
        }

        buttonTapped = viewModel.action
    }

    private func setupActions() {
        iconButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }

    // MARK: - Fileprivate functions

    @objc fileprivate func didButtonTapped() {
        buttonTapped?()
    }
}

private extension Selector {
    static let didButtonTapped = #selector(InfoListItemView.didButtonTapped)
}
