//
//  RecipesListsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest

import UIKit

final class RecipesListViewController: UITableViewController {
    
    var recipesLoader: RecipesListLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        title = "Recipes List"
        refresh()
    }
    
    @objc
    private func refresh() {
        recipesLoader?.load()
    }
    
}

protocol RecipesListLoader {
    func load()
}

final class LoaderSpy: RecipesListLoader {
    var loadRecipesCallCount: Int = 0
    
    func load() {
        loadRecipesCallCount += 1
    }
}

class RecipesListsUIIntegrationTests: XCTestCase {

    func test_view_hasTitle() {
        let sut = RecipesListViewController()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Recipes List")
    }
    
    func test_loadRecipesActions_requestRecipesFromLoader() {
        let loader = LoaderSpy()
        let sut = RecipesListViewController()
        sut.recipesLoader = loader
        
        XCTAssertEqual(loader.loadRecipesCallCount, 0)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadRecipesCallCount, 1)
        
        sut.simulateUserInitiatedRecipesReload()
        XCTAssertEqual(loader.loadRecipesCallCount, 2)
        
        sut.simulateUserInitiatedRecipesReload()
        XCTAssertEqual(loader.loadRecipesCallCount, 3)
    }

}

extension RecipesListViewController {
    func simulateUserInitiatedRecipesReload() {
        refreshControl?.sendActions(for: .valueChanged)
    }
}
