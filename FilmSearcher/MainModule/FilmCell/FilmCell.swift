//
//  FilmCell.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import UIKit
import SnapKit

// MARK: - FilmCell

final class FilmCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// Name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - UITableViewCell

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    // MARK: - Useful

    func setup(with viewModel: FilmCellViewModelProtocol) {
        nameLabel.text = viewModel.filmName
        setup()
    }
}

// MARK: - Setup

private extension FilmCell {
    
    func setup() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make
                .leading
                .top
                .equalToSuperview()
                .offset(16)
            make
                .trailing
                .bottom
                .equalToSuperview()
                .offset(-16)
        }
    }
}
