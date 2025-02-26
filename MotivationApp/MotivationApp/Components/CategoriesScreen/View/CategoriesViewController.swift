//
//  CathegoriesViewController.swift
//  MotivationApp
//
//  Created by Надежда Капацина on 24.02.2025.
//

import UIKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func didSelectCategory(_ category: String?)
}

class CategoriesViewController: UIViewController {
    private let viewModel = CategoriesViewModel()
    weak var delegate: CategoriesViewControllerDelegate?
    
    // MARK: - UI elements
    
    private let titleLabel = UILabel(
        title: """
        What makes you 
        feel that way?
        """,
        weight: .bold,
        size: 28
    )
    
    private let secondTitleLabel = UILabel(
        title: "you can select more than one",
        weight: .medium,
        size: 17
    )
    
    private let bottomTitleLabel = UILabel(
        title: "you can change it later",
        weight: .medium,
        size: 17
    )
    
    private let categoryTableView = UITableView()
    private let doneButton = UIButton()
    
    
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
        setupUI()
        setupTableView()
    }
    
    // MARK: - setupUI
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(secondTitleLabel)
        view.addSubview(categoryTableView)
        view.addSubview(bottomTitleLabel)
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        title = "Categories"
        view.backgroundColor = .white
    }
    
    // MARK: - setupTableView
    
    private func setupTableView() {
        categoryTableView.translatesAutoresizingMaskIntoConstraints = false
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.register(
                    CategoryTableViewCell.self,
                    forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier
                )
        categoryTableView.rowHeight = 60
        categoryTableView.separatorStyle = .none
        
        // Центрируем заголовки
            categoryTableView.estimatedSectionHeaderHeight = 50
            categoryTableView.sectionHeaderHeight = UITableView.automaticDimension
        
    }
}

extension CategoriesViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 50
            ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondTitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),
            secondTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            
            categoryTableView.topAnchor.constraint(
                 equalTo: secondTitleLabel.bottomAnchor,
                 constant: 50
             ),
             categoryTableView.leadingAnchor.constraint(
                 equalTo: view.leadingAnchor,
                 constant: 50
             ),
             categoryTableView.trailingAnchor.constraint(
                 equalTo: view.trailingAnchor,
                 constant: -50
             ),
             categoryTableView.bottomAnchor.constraint(
                 equalTo: bottomTitleLabel.topAnchor,
                 constant: -50
             ),
            
            bottomTitleLabel.bottomAnchor.constraint(
                equalTo: doneButton.topAnchor,
                constant: -20
            ),
            bottomTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            doneButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 120),
            doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // 8. Настраиваем кнопку
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .systemGreen
        doneButton.layer.cornerRadius = 8
        doneButton.addTarget(
            self,
            action: #selector(doneButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func doneButtonTapped() {
        // 9. Обработка нажатия на кнопку
        dismiss(animated: true)
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.allCategories.count + 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        let title = viewModel.categoryName(for: indexPath.row)
        let isSelected = viewModel.isCategorySelected(at: indexPath.row)
        cell.configure(with: title, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        viewModel.selectCategory(at: indexPath.row)
        
        var indexPathsToReload = [indexPath]
        
        if let previousSelectedIndex = viewModel.previouslySelectedIndex {
            indexPathsToReload.append(IndexPath(row: previousSelectedIndex, section: 0))
        }
        
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        delegate?.didSelectCategory(viewModel.selectedCategory)
    }
}
