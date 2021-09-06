//
//  RecipeDetailsPresenter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

struct RecipeDetailsViewModel {
    let title: String
    let description: String
    let calories: String
    let tags: String?
    let chef: String?
}

protocol DetailsView {
    func display(_ viewModel: RecipeDetailsViewModel)
}

protocol DetailsLoadingView {
    func display(isLoading: Bool)
}

protocol DetailsImageView {
    func display(image: UIImage?)
}

final class RecipeDetailsPresenter {
    static let title = "Recipe Details"
    
    private var recipeModel: RecipeModel
    private let recipeDetailsView: DetailsView
    private let recipeImageView: DetailsImageView
    private let recipeLoadingView: DetailsLoadingView
    
    init(recipeModel: RecipeModel, recipeDetailsView: DetailsView, recipeImageView: DetailsImageView, recipeLoadingView: DetailsLoadingView) {
        self.recipeModel = recipeModel
        self.recipeDetailsView = recipeDetailsView
        self.recipeImageView = recipeImageView
        self.recipeLoadingView = recipeLoadingView
    }
    
    func didStartLoadingRecipeImage() {
        recipeLoadingView.display(isLoading: true)
        recipeImageView.display(image: nil)
        recipeDetailsView.display(RecipeDetailsViewModel(title: recipeModel.title,
                                                         description: recipeModel.description,
                                                         calories: "Calories: \(recipeModel.calories)",
                                                         tags: tagsText(fromTags: recipeModel.tags),
                                                         chef: chefText(for: recipeModel.chefName)))
    }
    
    func didFinishLoadingImageData(with image: UIImage?) {
        recipeLoadingView.display(isLoading: false)
        recipeImageView.display(image: image)
    }
    
    private func tagsText(fromTags tags: [String]?) -> String {
        guard let tags = tags, !tags.isEmpty else { return "Tags: -" }
        var tagsText = tags.reduce("", { return $0 + $1 + ", " })
        tagsText.removeLast()
        tagsText.removeLast()
        return "Tags: " + tagsText
    }
    
    private func chefText(for chefName: String?) -> String {
        return "Chef: " + (chefName ?? "-")
    }
}
