//
//  FilmCell.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import UIKit
import SnapKit
import Kingfisher
import ReSwift

// MARK: - FilmCell

final class FilmCell: UITableViewCell, StoreSubscriber {
    
    // MARK: - Aliases
    
    typealias StoreSubscriberStateType = MainState
    
    // MARK: - Properties
    
    /// Name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    /// Poster image view
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// Link button
    private let linkButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.link.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = AppTheme.filmCellButtonsTintColor
        return button
    }()
    
    /// Share button
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.share.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = AppTheme.filmCellButtonsTintColor
        return button
    }()
    
    private var webURL: URL?
    
    func newState(state: MainState) {
    }
    
    // MARK: - UITableViewCell

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainStore.subscribe(self)
        self.selectionStyle = .none
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainStore.unsubscribe(self)
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
        posterImageView.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.cornerRadius = Constants.imageCornerRadius
    }
    
    // MARK: - Useful

    func setup(with viewModel: FilmCellViewModelProtocol) {
        nameLabel.text = viewModel.filmName
        posterImageView.kf.setImage(
            with: viewModel.imageURL,
            placeholder: Asset.photo.image
        ) { [weak self] _ in
            self?.posterImageView.contentMode = .scaleAspectFill
        }
        webURL = viewModel.webUrl
    }
}

// MARK: - Setup

private extension FilmCell {
    
    func setup() {
        setupPosterImageView()
        setupButtons()
        setupNameLabel()
    }
    
    func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
                .offset(Constants.contentViewVerticalInset)
            make
                .trailing
                .equalToSuperview()
                .offset(-Constants.contentViewHorizontalInset)
            make
                .bottom
                .equalToSuperview()
                .offset(-Constants.contentViewVerticalInset)
            make
                .height
                .equalTo(Constants.imageViewHeight)
            make
                .width
                .equalTo(Constants.imageViewWidth)
        }
    }
    
    func setupButtons() {
        contentView.addSubview(linkButton)
        linkButton.snp.makeConstraints { make in
            make
                .leading
                .equalToSuperview()
                .offset(Constants.contentViewHorizontalInset)
            make
                .bottom
                .equalToSuperview()
                .offset(-Constants.contentViewVerticalInset)
            make
                .size
                .equalTo(Constants.buttonSize)
        }
        linkButton.addTarget(self, action: #selector(linkButtonTap), for: .touchUpInside)
        contentView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make
                .leading
                .equalTo(linkButton.snp.trailing)
                .offset(Constants.buttonsInterspacing)
            make
                .bottom
                .equalTo(linkButton.snp.bottom)
            make
                .size
                .equalTo(Constants.buttonSize)
        }
        shareButton.addTarget(self, action: #selector(shareButtonTap), for: .touchUpInside)
    }
    
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
                .offset(Constants.contentViewVerticalInset)
            make
                .leading
                .equalToSuperview()
                .offset(Constants.contentViewHorizontalInset)
            make
                .trailing
                .equalTo(posterImageView.snp.leading)
                .offset(-Constants.contentViewInterspacing)
            make
                .bottom
                .equalTo(linkButton.snp.top)
                .offset(-Constants.contentViewVerticalInset)
        }
    }
}

// MARK: - FilmCell

private extension FilmCell {
    
    @objc func linkButtonTap() {
        guard let url = webURL else { return }
        animateButton(button: linkButton)
        UIApplication.shared.open(url)
    }
    
    @objc func shareButtonTap() {
        guard let url = webURL else { return }
        animateButton(button: shareButton)
        mainStore.dispatch(ShareButtonTapAction(url: url))
    }
    
    func animateButton(button: UIButton) {
        UIView.animate(withDuration: 0.38) {
            button.alpha = 0.62
        }
        UIView.animate(withDuration: 0.62, delay: 0.38) {
            button.alpha = 1
        }
    }
}

// MARK: - Constants

extension FilmCell {
    
    enum Constants {
        static let contentViewHorizontalInset: CGFloat = 16
        static let imageViewHeight: CGFloat = 100
        static let imageViewWidth: CGFloat = 65
        static let contentViewVerticalInset: CGFloat = 8
        static let contentViewInterspacing: CGFloat = 8
        static let imageCornerRadius: CGFloat = 11
        static let buttonsInterspacing: CGFloat = 12
        static let buttonSize: CGFloat = 24
    }
}
