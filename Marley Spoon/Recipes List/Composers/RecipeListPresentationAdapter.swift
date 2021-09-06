//
//  RecipeListPresentationAdapter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

final class RecipesListPresentationAdapter: RecipesListViewControllerDelegate {
    private let recipesLoader: RecipesListLoader
    var presenter: RecipesListPresenter?
    
    init(recipesLoader: RecipesListLoader) {
        self.recipesLoader = recipesLoader
    }
    
    func didRequestListRefresh() {
        presenter?.didStartLoadingRecipesList()
        
        recipesLoader.load { [weak self] result in
            switch result {
            case let .success(models):
                self?.presenter?.didFinishLoadingRecipesList(with: models)
            case let .failure(error):
                print(error)
                self?.presenter?.didFinishLoadingRecipesList(with: [])
            }
        }
    }
    
}
