//
//  CocktailCell.swift
//  SchibstedCocktails2
//
//  Created by Uladzislau Makei on 25.05.25.
//

import UIKit
import NetworkingLibrary

final class CocktailCell: UITableViewCell {
    private let cocktailImageView = UIImageView()
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cocktailImageView.contentMode = .scaleAspectFill
        cocktailImageView.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)

        let stack = UIStackView(arrangedSubviews: [cocktailImageView, nameLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        cocktailImageView.translatesAutoresizingMaskIntoConstraints = false
        cocktailImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        cocktailImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with cocktail: Cocktail) {
        nameLabel.text = cocktail.name
        Task {
            guard let url = URL(string: cocktail.imageUrl) else { return }
            if let (data, _) = try? await URLSession.shared.data(from: url),
               let image = UIImage(data: data) {
                cocktailImageView.image = image
            }
        }
    }}
