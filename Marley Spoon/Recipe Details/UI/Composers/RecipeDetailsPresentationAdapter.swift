//
//  RecipeDetailsPresentationAdapter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

final class RecipeDetailsPresentationAdapter: RecipeDetailsViewControllerDelegate {
    private let imageLoader: ImageDataLoader
    private let imageId: String?
    
    var presenter: RecipeDetailsPresenter?
    
    private enum Error: Swift.Error {
        case imageIdNotFound
    }
    
    init(imageLoader: ImageDataLoader, imageId: String?) {
        self.imageLoader = imageLoader
        self.imageId = imageId
    }
    
    func didRequestLoadImage() {
        presenter?.didStartLoadingRecipeImage()
        guard let imageId = self.imageId else {
            presenter?.didFinishLoadingImageData(with: nil)
            return
        }
        imageLoader.loadImageData(forImageId: imageId) { [weak self] result in
            switch result {
            case let .success(image):
                self?.presenter?.didFinishLoadingImageData(with: image)
            case .failure:
                self?.presenter?.didFinishLoadingImageData(with: nil)
            }
        }
    }
    
}
