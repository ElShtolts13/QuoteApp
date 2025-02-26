//
//  CategoryTableViewCEll.swift
//  MotivationApp
//
//  Created by Надежда Капацина on 24.02.2025.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CategoryTableViewCell"
    
    // MARK: - UI elements
    
    let categoryLabel = UILabel(title: "", weight: .regular, size: 20)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        selectionStyle = .none
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1 // 11. Добавляем границу
        contentView.layer.borderColor = UIColor.systemGreen.cgColor
    }
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                categoryLabel.leadingAnchor.constraint(
                                equalTo: contentView.leadingAnchor,
                                constant: 20
                            ),
                            categoryLabel.trailingAnchor.constraint(
                                equalTo: contentView.trailingAnchor,
                                constant: -20
                            ),
                            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        contentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    
    // MARK: - Configuration
    func configure(with title: String, isSelected: Bool) {
        categoryLabel.text = title
        contentView.backgroundColor = isSelected ?
            UIColor.systemGreen.withAlphaComponent(0.1) :
            .clear
        contentView.layer.cornerRadius = 12
    }
    
    private func updateSelectionAppearance(isSelected: Bool) {
            UIView.animate(withDuration: 0.3) {
                self.contentView.backgroundColor = isSelected ?
                    UIColor.systemGreen.withAlphaComponent(0.2) :
                    .clear
                self.categoryLabel.font = isSelected ?
                    UIFont.systemFont(ofSize: 20, weight: .bold) :
                    UIFont.systemFont(ofSize: 20, weight: .regular)
            }
    }
}
