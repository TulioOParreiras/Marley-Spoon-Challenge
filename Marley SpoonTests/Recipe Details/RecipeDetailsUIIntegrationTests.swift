//
//  RecipeDetailsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest
import Marley_Spoon

final class RecipeDetailsViewController: UIViewController {
    
    var model: RecipeModel?
    var imageLoader: ImageDataLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
        
        if let imageId = model?.imageId {
            imageLoader?.loadImageData(forImageId: imageId, completion: { _ in })
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
    
    // MARK: - Helpers
    
    private func makeSUT(model: RecipeModel = makeRecipe()) -> (sut: RecipeDetailsViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = RecipeDetailsViewController()
        sut.model = model
        sut.imageLoader = loader
        return (sut, loader)
    }

}
