//
//  WeakRefVirtualProxy.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: ListLoadingView where T: ListLoadingView {
    func display(isLoading: Bool) {
        object?.display(isLoading: isLoading)
    }
}

extension WeakRefVirtualProxy: RecipeView where T: RecipeView {
    func display(_ model: RecipeViewModel) {
        object?.display(model)
    }
}

extension WeakRefVirtualProxy: DetailsView where T: DetailsView {
    func display(_ viewModel: RecipeDetailsViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: DetailsLoadingView where T: DetailsLoadingView {
    func display(isLoading: Bool) {
        object?.display(isLoading: isLoading)
    }
}

extension WeakRefVirtualProxy: DetailsImageView where T: DetailsImageView {
    func display(image: UIImage?) {
        object?.display(image: image)
    }
}
