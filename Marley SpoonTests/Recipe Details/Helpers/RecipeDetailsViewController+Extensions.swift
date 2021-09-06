//
//  RecipeDetailsViewController+Extensions.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit
import Marley_Spoon

extension RecipeDetailsViewController {
    var isShowingImageLoadingIndicator: Bool {
        return spinner.isAnimating
    }
    
    var renderedImage: UIImage? {
        return imageView.image
    }
    
    var titleText: String? {
        return titleLabel.text
    }
    
    var caloriesText: String? {
        return caloriesLabel.text
    }
    
    var chefText: String? {
        return chefLabel.text
    }
    
    var tagsText: String? {
        return tagsLabel.text
    }
    
    var descriptionText: String? {
        return descriptionLabel.text
    }
}
