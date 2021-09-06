//
//  RecipeDetailsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest
import Marley_Spoon

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
    
    func test_loadView_rendersSuccessfullyRecipeDetails_withIncompleteRecipe() {
        let model = makeRecipe()
        let (sut, _) = makeSUT(model: model)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.titleText, model.title)
        XCTAssertEqual(sut.caloriesText, "Calories: \(model.calories)")
        XCTAssertEqual(sut.chefText, "Chef: -")
        XCTAssertEqual(sut.tagsText, "Tags: -")
        XCTAssertEqual(sut.descriptionText, model.description)
    }
    
    func test_loadView_rendersSuccessfullyRecipeDetails_withOneTag() {
        let model = makeRecipe(tags: ["A tag"], chefName: "A chef")
        let (sut, _) = makeSUT(model: model)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.titleText, model.title)
        XCTAssertEqual(sut.caloriesText, "Calories: \(model.calories)")
        XCTAssertEqual(sut.chefText, "Chef: \(model.chefName!)")
        XCTAssertEqual(sut.tagsText, "Tags: A tag")
        XCTAssertEqual(sut.descriptionText, model.description)
    }
    
    func test_loadView_rendersSuccessfullyRecipeDetails_withCompleteRecipe() {
        let model = makeRecipe(tags: ["A tag", "Another tag"], chefName: "A chef")
        let (sut, _) = makeSUT(model: model)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.titleText, model.title)
        XCTAssertEqual(sut.caloriesText, "Calories: \(model.calories)")
        XCTAssertEqual(sut.chefText, "Chef: \(model.chefName!)")
        XCTAssertEqual(sut.tagsText, "Tags: A tag, Another tag")
        XCTAssertEqual(sut.descriptionText, model.description)
    }
    
    func test_loadImageDataCompletion_dispatchesFromBackgroundToMainThread() {
        let (sut, loader) = makeSUT(model: makeRecipe(imageId: "A id"))
        
        sut.loadViewIfNeeded()
        
        let exp = expectation(description: "Wait for background queue")
        DispatchQueue.global().async {
            let image = UIImage.make(withColor: .red)
            loader.completeImageLoading(with: image)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(model: RecipeModel = makeRecipe(), file: StaticString = #file, line: UInt = #line) -> (sut: RecipeDetailsViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = RecipeDetailsUIComposer.recipeDetailsComposedWith(imageLoader: loader, recipeModel: model)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        return (sut, loader)
    }

}
