//
//  TapBarController.swift
//  MotivationApp
//
//  Created by Надежда Капацина on 23.02.2025.
//

import UIKit

class TapBarController: UITabBarController {
    private let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        configureTabBar()
        setupCenterButton()
        selectedIndex = 1
    }
    
    private func setupTabs() {
       
        let post = createNav(title: "Post a Quote", image: "pencil.and.list.clipboard", vc: PostaQuoteViewController())
        let home = createNav(title: "", image: "", vc: CategoriesViewController())
        let favorites = createNav(title: "Favorites", image: "bookmark", vc: FavoritesViewController())
        
        setViewControllers([post, home, favorites], animated: true)
    }
    
    private func configureTabBar() {
        tabBar.tintColor = UIColor(red: 0.13, green: 0.73, blue: 0.32, alpha: 1.00)
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .clear
    }
    
    private func setupCenterButton() {
        centerButton.backgroundColor = UIColor(red: 0.13, green: 0.73, blue: 0.32, alpha: 1.00)
        centerButton.tintColor = .white
        centerButton.layer.cornerRadius = 30
        centerButton.layer.masksToBounds = true
        centerButton.setImage(UIImage(systemName: "house"), for: .normal)
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        
        tabBar.addSubview(centerButton)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 20),
            centerButton.widthAnchor.constraint(equalToConstant: 60),
            centerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func centerButtonTapped() {
        selectedIndex = 1
    }
    
    private func createNav(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.title = title
        vc.navigationItem.title = title
        return nav
    }
}

extension TapBarController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.bringSubviewToFront(centerButton)
    }
}
