//
//  RecipesListsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest
@testable import Marley_Spoon
import UIKit

class RecipesListsUIIntegrationTests: XCTestCase {

    func test_view_hasTitle() {
        let (sut, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Recipes List")
    }
    
    func test_loadRecipesActions_requestRecipesFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadRecipesCallCount, 0)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadRecipesCallCount, 1)
        
        sut.simulateUserInitiatedRecipesReload()
        XCTAssertEqual(loader.loadRecipesCallCount, 2)
        
        sut.simulateUserInitiatedRecipesReload()
        XCTAssertEqual(loader.loadRecipesCallCount, 3)
    }
    
    func test_loadingRecipesIndicator_isVisibleWhileLoadingRecipes() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.completeRecipesLoad(at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator)
        
        sut.simulateUserInitiatedRecipesReload()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.completeRecipesLoad(at: 1)
        XCTAssertFalse(sut.isShowingLoadingIndicator)
    }
    
    func test_loadRecipesCompletion_rendersSuccessfullyLoadedRecipes() {
        let recipe0 = makeRecipe(title: "A title")
        let recipe1 = makeRecipe(title: "Another title")
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        assertThat(sut, isRendering: [])
        
        loader.completeRecipesLoad(with: [recipe0], at: 0)
        assertThat(sut, isRendering: [recipe0])

        sut.simulateUserInitiatedRecipesReload()
        loader.completeRecipesLoad(with: [recipe0, recipe1], at: 1)
        assertThat(sut, isRendering: [recipe0, recipe1])
    }
    
    func test_recipeView_loadsImageIdWhenVisible() {
        let recipe0 = makeRecipe(title: "A title", imageId: nil)
        let recipe1 = makeRecipe(title: "Another title", imageId: "a id")
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeRecipesLoad(with: [recipe0, recipe1])
        
        XCTAssertEqual(loader.loadedImageIds, [])

        sut.simulateRecipeViewVisible(at: 0)
        XCTAssertEqual(loader.loadedImageIds, [])
        
        sut.simulateRecipeViewVisible(at: 1)
        XCTAssertEqual(loader.loadedImageIds, [recipe1.imageId])
    }
    
    func test_recipeViewLoadingIndicator_isVisibleWhileLoadingImage() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeRecipesLoad(with: [makeRecipe(title: "Another title", imageId: "a id"), makeRecipe(title: "Another title", imageId: "a id")])
        
        let view0 = sut.simulateRecipeViewVisible(at: 0)
        let view1 = sut.simulateRecipeViewVisible(at: 1)
        XCTAssertEqual(view0?.isShowingImageLoadingIndicator, true)
        XCTAssertEqual(view1?.isShowingImageLoadingIndicator, true)
        
        loader.completeImageLoading(at: 0)
        XCTAssertEqual(view0?.isShowingImageLoadingIndicator, false)
        XCTAssertEqual(view1?.isShowingImageLoadingIndicator, true)
        
        loader.completeImageLoadingWithError(at: 1)
        XCTAssertEqual(view0?.isShowingImageLoadingIndicator, false)
        XCTAssertEqual(view1?.isShowingImageLoadingIndicator, false)
    }
    
    func test_recipeView_rendersImageLoadedFromId() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeRecipesLoad(with: [makeRecipe(title: "Another title", imageId: "a id"), makeRecipe(title: "Another title", imageId: "a id")])
        
        let view0 = sut.simulateRecipeViewVisible(at: 0)
        let view1 = sut.simulateRecipeViewVisible(at: 1)
        XCTAssertEqual(view0?.renderedImage, .none, "Expected no image for first view while loading first image")
        XCTAssertEqual(view1?.renderedImage, .none, "Expected no image for second view while loading second image")
        
        let image0 = UIImage.make(withColor: .red)
        loader.completeImageLoading(with: image0, at: 0)
        XCTAssertEqual(view0?.renderedImage, image0)
        XCTAssertEqual(view1?.renderedImage, .none, "Expected no image state change for second view once first image loading completes successfully")
        
        let image1 = UIImage.make(withColor: .blue)
        loader.completeImageLoading(with: image1, at: 1)
        XCTAssertEqual(view0?.renderedImage, image0)
        XCTAssertEqual(view1?.renderedImage, image1)
    }
    
    func test_recipeView_preloadsImageIdWhenNearVisible() {
        let recipe0 = makeRecipe(title: "A title", imageId: "a id")
        let recipe1 = makeRecipe(title: "Another title", imageId: "a id")
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeRecipesLoad(with: [recipe0, recipe1])
        XCTAssertEqual(loader.loadedImageIds, [])
        
        sut.simulateRecipeViewNearVisible(at: 0)
        XCTAssertEqual(loader.loadedImageIds, [recipe0.imageId])
        
        sut.simulateRecipeViewNearVisible(at: 1)
        XCTAssertEqual(loader.loadedImageIds, [recipe0.imageId, recipe1.imageId])
    }
    
    func test_recipeView_doesNotRenderLoadedImageWhenNotVisibleAnymore() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        loader.completeRecipesLoad(with: [makeRecipe(title: "Another title", imageId: "a id")])

        let view = sut.simulateRecipeViewNotVisible(at: 0)
        let image0 = UIImage.make(withColor: .red)
        loader.completeImageLoading(with: image0)
        
        XCTAssertNil(view?.renderedImage, "Expected no rendered image when an image load finishes after the view is not visible anymore")
    }
    
    func test_loadRecipesCompletion_dispatchesFromBackgroundToMainThread() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()

        let exp = expectation(description: "Wait for background queue")
        DispatchQueue.global().async {
            loader.completeRecipesLoad(at: 0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_loadImageDataCompletion_dispatchesFromBackgroundToMainThread() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeRecipesLoad(with: [makeRecipe(title: "Another title", imageId: "a id")])
        _ = sut.simulateRecipeViewVisible(at: 0)
        
        let exp = expectation(description: "Wait for background queue")
        DispatchQueue.global().async {
            let image0 = UIImage.make(withColor: .red)
            loader.completeImageLoading(with: image0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: RecipesListViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = RecipesListUIComposer.recipesListComposedWith(recipesLoader: loader, imageLoader: loader, onSelect: { _ in })
        return (sut, loader)
    }
    
    private func makeRecipe(title: String, description: String = "A desription", calories: Int = 100, tags: [String]? = nil, imageId: String? = nil, chefName: String? = nil) -> RecipeModel {
        RecipeModel(title: title, description: description, calories: calories, tags: tags, imageId: imageId, chefName: chefName)
    }

}
