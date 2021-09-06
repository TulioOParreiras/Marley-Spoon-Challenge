//
//  RecipePresentationAdapter.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

final class RecipePresentationAdapter: RecipeCellControllerDelegate {
    private let model: RecipeModel
    private let imageLoader: ImageDataLoader
    
    var presenter: RecipePresenter?
    
    private enum Error: Swift.Error {
        case imageIdNotFound
    }
    
    internal init(model: RecipeModel, imageLoader: ImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        guard let imageId = model.imageId else {
            self.presenter?.didFinishLoadingImageData(with: Error.imageIdNotFound, for: model)
            return
        }
        presenter?.didStartLoadingImageData(for: model)
        
        let model = self.model
        imageLoader.loadImageData(forImageId: imageId) { [weak self] result in
            switch result {
            case let .success(image):
                self?.presenter?.didFinishLoadingImageData(with: image, for: model)
            case let .failure(error):
                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
            }
        }
    }
}
