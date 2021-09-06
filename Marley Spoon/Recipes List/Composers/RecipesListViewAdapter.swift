//
//  RecipesListViewAdapter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

final class RecipesListViewAdapter: RecipesListView {
    private weak var controller: RecipesListViewController?
    private let imageLoader: ImageDataLoader
    
    init(controller: RecipesListViewController, imageLoader: ImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(listModels: [RecipeModel]) {
        controller?.tableModel = listModels.map { model in
            let adapter = RecipePresentationAdapter(model: model, imageLoader: imageLoader)
            let view = RecipeCellController(delegate: adapter)
            
            adapter.presenter = RecipePresenter(view: view)
            return view
        }
    }
}
