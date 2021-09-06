//
//  RecipeDetailsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest
import Marley_Spoon

final class RecipeDetailsViewController: UIViewController {
    
    public let imageView = UIImageView()
    public let spinner = UIActivityIndicatorView()
    
    var model: RecipeModel?
    var imageLoader: ImageDataLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
        
        spinner.startAnimating()
        if let imageId = model?.imageId {
            imageLoader?.loadImageData(forImageId: imageId, completion: { result in
                self.spinner.stopAnimating()
                self.imageView.image = try? result.get()
            })
        }
    }
    
}

final class RecipeDetailsUIIntegrationTests: XCTestCase {
    
    func test_view_hasTitle() {
        let (sut, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Recipe Details")
    }
    
    func test_loadImageActions_requestImageFromLoader() {
        let model = makeRecipe(imageId: "A id")
        let (sut, loader) = makeSUT(model: model)
        
        XCTAssertEqual(loader.loadedImageIds, [])
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadedImageIds, [model.imageId])
    }
    
    func test_loadImageActions_doesNotRequestImageFromLoader_forNilImageId() {
        let model = makeRecipe()
        let (sut, loader) = makeSUT(model: model)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadedImageIds, [])
    }
    
    func test_loadingImageIndicator_isVisibleWhileLoadingImage() {
        let model = makeRecipe(imageId: "A id")
        let (sut, loader) = makeSUT(model: model)
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isShowingImageLoadingIndicator)
        
        loader.completeImageLoading()
        XCTAssertFalse(sut.isShowingImageLoadingIndicator)
    }
    
    func test_view_rendersImageLoaded() {
        let model = makeRecipe(imageId: "A id")
        let (sut, loader) = makeSUT(model: model)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.renderedImage, .none)
        let image = UIImage.make(withColor: .red)
        loader.completeImageLoading(with: image)
        
        XCTAssertEqual(sut.renderedImage, image)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(model: RecipeModel = makeRecipe()) -> (sut: RecipeDetailsViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = RecipeDetailsViewController()
        sut.model = model
        sut.imageLoader = loader
        return (sut, loader)
    }

}

extension RecipeDetailsViewController {
    var isShowingImageLoadingIndicator: Bool {
        return spinner.isAnimating
    }
    
    var renderedImage: UIImage? {
        return imageView.image
    }
}
