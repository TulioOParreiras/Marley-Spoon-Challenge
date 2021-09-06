//
//  RecipesListsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest
@testable import Marley_Spoon
import UIKit

final class LoaderSpy: RecipesListLoader {
    var loadRecipesRequests = [(RecipesListLoader.Result) -> Void]()
    var loadRecipesCallCount: Int { loadRecipesRequests.count }
    
    func load(completion: @escaping (RecipesListLoader.Result) -> Void) {
        loadRecipesRequests.append(completion)
    }
    
    func completeRecipesLoad(at index: Int = 0) {
        loadRecipesRequests[index](.success(()))
    }
}

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
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: RecipesListViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = RecipesListViewController()
        sut.recipesLoader = loader
        
        return (sut, loader)
    }

}

extension RecipesListViewController {
    func simulateUserInitiatedRecipesReload() {
        refreshControl?.sendActions(for: .valueChanged)
    }
    
    var isShowingLoadingIndicator: Bool {
        refreshControl?.isRefreshing ?? false
    }
}
