//
//  RecipesListViewController+Extensions.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit
import Marley_Spoon

extension RecipesListViewController {
    func simulateUserInitiatedRecipesReload() {
        refreshControl?.sendActions(for: .valueChanged)
    }
    
    @discardableResult
    func simulateRecipeViewVisible(at index: Int) -> RecipeCell? {
        return recipeView(at: index) as? RecipeCell
    }
    
    @discardableResult
    func simulateRecipeViewNotVisible(at row: Int) -> RecipeCell? {
        let view = simulateRecipeViewVisible(at: row)
        
        let delegate = tableView.delegate
        let index = IndexPath(row: row, section: recipesSection)
        delegate?.tableView?(tableView, didEndDisplaying: view!, forRowAt: index)
        
        return view
    }
    
    func simulateRecipeViewNearVisible(at row: Int) {
        let ds = tableView.prefetchDataSource
        let index = IndexPath(row: row, section: recipesSection)
        ds?.tableView(tableView, prefetchRowsAt: [index])
    }
    
    var isShowingLoadingIndicator: Bool {
        refreshControl?.isRefreshing ?? false
    }
    
    func numberOfRenderedRecipeViews() -> Int {
        return tableView.numberOfRows(inSection: recipesSection)
    }
    
    func recipeView(at row: Int) -> UITableViewCell? {
        let ds = tableView.dataSource
        let index = IndexPath(row: row, section: recipesSection)
        return ds?.tableView(tableView, cellForRowAt: index)
    }
    
    private var recipesSection: Int {
        return 0
    }
}
