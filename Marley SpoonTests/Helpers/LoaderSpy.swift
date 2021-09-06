//
//  LoaderSpy.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit
import Marley_Spoon

final class LoaderSpy: RecipesListLoader, ImageDataLoader {
    
    // MARK: - RecipesListLoader
    
    var loadRecipesRequests = [(RecipesListLoader.Result) -> Void]()
    var loadRecipesCallCount: Int { loadRecipesRequests.count }
    
    func load(completion: @escaping (RecipesListLoader.Result) -> Void) {
        loadRecipesRequests.append(completion)
    }
    
    func completeRecipesLoad(with models: [RecipeModel] = [], at index: Int = 0) {
        loadRecipesRequests[index](.success(models))
    }
    
    // MARK: - ImageDataLoader
    
    private var imageRequests = [(id: String, completion: (ImageDataLoader.Result) -> Void)]()
    
    var loadedImageIds: [String] {
        return imageRequests.map { $0.id }
    }
    
    func loadImageData(forImageId imageId: String, completion: @escaping (ImageDataLoader.Result) -> Void) {
        imageRequests.append((imageId, completion))
    }
    
    func completeImageLoading(with image: UIImage = UIImage(), at index: Int = 0) {
        imageRequests[index].completion(.success(image))
    }
    
    func completeImageLoadingWithError(at index: Int = 0) {
        let error = NSError(domain: "an error", code: 0)
        imageRequests[index].completion(.failure(error))
    }
}
