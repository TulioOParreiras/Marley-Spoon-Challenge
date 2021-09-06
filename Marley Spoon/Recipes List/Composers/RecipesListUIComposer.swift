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
    
    public static func recipesListComposedWith(recipesLoader: RecipesListLoader, imageLoader: ImageDataLoader) ->  RecipesListViewController {
        let presentationAdapter = RecipesListPresentationAdapter(recipesLoader: recipesLoader)
        
        let controller = RecipesListViewController(delegate: presentationAdapter)
        controller.title = "Recipes List"
        
        presentationAdapter.presenter = RecipesListPresenter(recipesListView: RecipesListViewAdapter(controller: controller,
                                                                                                     imageLoader: imageLoader),
                                                             recipesListLoadingView: controller)
        
        return controller
    }
    
    
}
