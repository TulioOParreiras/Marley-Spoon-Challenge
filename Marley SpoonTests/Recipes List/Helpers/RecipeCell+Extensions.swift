//
//  RecipeCell+Extensions.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit
import Marley_Spoon

extension RecipeCell {
    var isShowingImageLoadingIndicator: Bool {
        return spinner.isAnimating
    }
    
    var titleText: String? {
        return recipeTitleLabel.text
    }
    
    var renderedImage: UIImage? {
        return recipeImageView.image
    }
}
