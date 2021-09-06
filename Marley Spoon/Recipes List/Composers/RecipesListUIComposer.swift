//
//  RecipesListUIComposer.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation
import UIKit

public final class RecipesListUIComposer {
    
    private init() { }
    
    public static func recipesListComposedWith(recipesLoader: RecipesListLoader, imageLoader: ImageDataLoader, onSelect: @escaping (RecipeModel) -> Void) ->  RecipesListViewController {
        let presentationAdapter = RecipesListPresentationAdapter(recipesLoader: MainQueueDispatchDecorator(decoratee: recipesLoader))
        
        let controller = RecipesListViewController(delegate: presentationAdapter)
        controller.title = RecipesListPresenter.title
        
        presentationAdapter.presenter = RecipesListPresenter(recipesListView: RecipesListViewAdapter(controller: controller,
                                                                                                     imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader),
                                                                                                     onSelect: onSelect),
                                                             recipesListLoadingView: WeakRefVirtualProxy(controller))
        
        return controller
    }
    
    
}
