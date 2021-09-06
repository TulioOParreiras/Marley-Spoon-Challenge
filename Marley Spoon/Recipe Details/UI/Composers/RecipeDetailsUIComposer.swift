//
//  RecipeDetailsUIComposer.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

public final class RecipeDetailsUIComposer {
    private init() { }
    
    public static func recipeDetailsComposedWith(imageLoader: ImageDataLoader, recipeModel: RecipeModel) -> RecipeDetailsViewController {
        let interactor = RecipeDetailsPresentationAdapter(imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader), imageId: recipeModel.imageId)
        
        let controller = RecipeDetailsViewController(delegate: interactor)
        controller.title = "Recipe Details"
        
        interactor.presenter = RecipeDetailsPresenter(recipeModel: recipeModel,
                                                      recipeDetailsView: controller,
                                                      recipeImageView: controller,
                                                      recipeLoadingView: controller)
        
        return controller
    }
}
