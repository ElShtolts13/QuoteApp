//
//  CathegoriesViewModel.swift
//  MotivationApp
//
//  Created by Надежда Капацина on 24.02.2025.
//

import Foundation

class CategoriesViewModel {
    let allCategories = [
        "age", "alone", "amazing", "anger",
        "architecture", "art", "attitude", "beauty",
        "best", "birthday"
    ]
    
    private(set) var selectedCategory: String?
    var previouslySelectedIndex: Int? // 12. Добавляем свойство
    
    func categoryName(for index: Int) -> String {
        if index == 0 {
            return "All Categories"
        }
        return allCategories[index - 1].capitalized
    }
    
    func isCategorySelected(at index: Int) -> Bool {
        if index == 0 {
            return selectedCategory == nil
        }
        return selectedCategory == allCategories[index - 1]
    }
    
    func selectCategory(at index: Int) {
        let newSelectedIndex = index == 0 ? nil : index
        
        if let previous = previouslySelectedIndex {
            if previous == index {
                previouslySelectedIndex = nil
                selectedCategory = nil
                return
            }
        }
        
        previouslySelectedIndex = newSelectedIndex
        selectedCategory = newSelectedIndex != nil ?
            allCategories[index - 1] :
            nil
    }
}
