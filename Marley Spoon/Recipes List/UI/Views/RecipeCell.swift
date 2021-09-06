//
//  RecipeCell.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

public final class RecipeCell: UITableViewCell {
    
    private(set) public lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private(set) public lazy var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) public lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .medium
        return spinner
    }()
    
    enum CellConstants {
        static let padding: CGFloat = 8
        static let imageSize: CGFloat = 32
        static let titleMinimumHeight: CGFloat = 48
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(recipeImageView)
        contentView.addConstraints([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CellConstants.padding),
            recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: CellConstants.imageSize)
        ])
        
        contentView.addSubview(recipeTitleLabel)
        contentView.addConstraints([
            recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: CellConstants.padding),
            recipeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellConstants.padding),
            recipeTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CellConstants.padding),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CellConstants.padding),
            recipeTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: CellConstants.titleMinimumHeight)
        ])
        
        contentView.addSubview(spinner)
        contentView.addConstraints([
            spinner.centerYAnchor.constraint(equalTo: recipeImageView.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: recipeImageView.centerXAnchor)
        ])
    }
}
