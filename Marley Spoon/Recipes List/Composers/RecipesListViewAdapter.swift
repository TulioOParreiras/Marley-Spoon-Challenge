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
    private let onSelect: (RecipeModel) -> Void
    
    init(controller: RecipesListViewController, imageLoader: ImageDataLoader, onSelect: @escaping (RecipeModel) -> Void) {
        self.controller = controller
        self.imageLoader = imageLoader
        self.onSelect = onSelect
    }
    
    func display(listModels: [RecipeModel]) {
        controller?.tableModel = listModels.map { model in
            let adapter = RecipePresentationAdapter(model: model, imageLoader: imageLoader)
            let view = RecipeCellController(delegate: adapter,
                                            onSelect: { [onSelect] in
                                                onSelect(model)
                                            })
            
            adapter.presenter = RecipePresenter(view: WeakRefVirtualProxy(view))
            return view
        }
    }
}
