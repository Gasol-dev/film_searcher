//
//  FilmCell.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: - FilmCell

final class FilmCell: UITableViewCell {
    
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
    
    // MARK: - UITableViewCell

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
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
            placeholder: UIImage(systemName: "photo")) { [weak self] _ in
                self?.posterImageView.contentMode = .scaleAspectFill
            }
    }
}

// MARK: - Setup

private extension FilmCell {
    
    func setup() {
        setupPosterImageView()
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
                .equalToSuperview()
                .offset(-Constants.contentViewVerticalInset)
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
    }
}
