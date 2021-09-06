//
//  RecipesListsUIIntegrationTests+Extensions.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit
import XCTest
import Marley_Spoon

extension RecipesListsUIIntegrationTests {

    func assertThat(_ sut: RecipesListViewController, isRendering recipes: [RecipeModel], file: StaticString = #file, line: UInt = #line) {
        guard sut.numberOfRenderedRecipeViews() == recipes.count else {
            return XCTFail("Expected \(recipes.count) images, got \(sut.numberOfRenderedRecipeViews()) instead.", file: file, line: line)
        }
        
        recipes.enumerated().forEach { index, recipe in
            assertThat(sut, hasViewConfiguredFor: recipe, at: index, file: file, line: line)
        }
    }
    
    func assertThat(_ sut: RecipesListViewController, hasViewConfiguredFor recipe: RecipeModel, at index: Int, file: StaticString = #file, line: UInt = #line) {
        let view = sut.recipeView(at: index)
        
        guard let cell = view as? RecipeCell else {
            return XCTFail("Expected \(RecipeCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
        }
        
        XCTAssertEqual(cell.titleText, recipe.title, file: file, line: line)
    }
    
}
