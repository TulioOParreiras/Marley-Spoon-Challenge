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
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: RecipesListViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = RecipesListViewController()
        sut.recipesLoader = loader
        sut.imageLoader = loader
        return (sut, loader)
    }
    
    private func makeRecipe(title: String, description: String = "A desription", calories: Int = 100, tags: [String]? = nil, imageId: String? = nil, chefName: String? = nil) -> RecipeModel {
        RecipeModel(title: title, description: description, calories: calories, tags: tags, imageId: imageId, chefName: chefName)
    }

}

extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
