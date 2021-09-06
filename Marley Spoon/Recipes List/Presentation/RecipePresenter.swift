//
//  RecipePresenter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

struct RecipeViewModel {
    let title: String?
    let image: UIImage?
    let isLoading: Bool
}

protocol RecipeView {
    func display(_ viewModel: RecipeViewModel)
}

final class RecipePresenter {
    private let view: RecipeView
    
    init(view: RecipeView) {
        self.view = view
    }
    
    func didStartLoadingImageData(for model: RecipeModel) {
        view.display(RecipeViewModel(title: model.title,
                                     image: nil,
                                     isLoading: true))
    }
    
    private struct InvalidImageDataError: Error {}
    
    func didFinishLoadingImageData(with image: UIImage, for model: RecipeModel) {
        view.display(RecipeViewModel(title: model.title,
                                     image: image,
                                     isLoading: false))
    }
    
    func didFinishLoadingImageData(with error: Error, for model: RecipeModel) {
        view.display(RecipeViewModel(title: model.title,
                                     image: nil,
                                     isLoading: false))
    }
}
