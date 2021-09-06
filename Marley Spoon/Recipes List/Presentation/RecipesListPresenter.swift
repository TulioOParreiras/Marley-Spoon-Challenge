//
//  RecipesListPresenter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

protocol RecipesListView {
    func display(listModels: [RecipeModel])
}

protocol ListLoadingView {
    func display(isLoading: Bool)
}

final class RecipesListPresenter {
    static let title = "Recipes List"
    
    private let recipesListView: RecipesListView
    private let recipesListLoadingView: ListLoadingView
    
    init(recipesListView: RecipesListView, recipesListLoadingView: ListLoadingView) {
        self.recipesListView = recipesListView
        self.recipesListLoadingView = recipesListLoadingView
    }
    
    func didStartLoadingRecipesList() {
        recipesListLoadingView.display(isLoading: true)
    }
    
    func didFinishLoadingRecipesList(with recipes: [RecipeModel]) {
        recipesListView.display(listModels: recipes)
        recipesListLoadingView.display(isLoading: false)
    }
    
}
