//
//  XCTest+SharedHelpers.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Marley_Spoon
import XCTest

func makeRecipe(title: String = "A title",
                description: String = "A desription",
                calories: Int = 100,
                tags: [String]? = nil,
                imageId: String? = nil,
                chefName: String? = nil) -> RecipeModel {
    RecipeModel(title: title,
                description: description,
                calories: calories,
                tags: tags,
                imageId: imageId,
                chefName: chefName)
}

extension XCTestCase {
    func trackForMemoryLeaks(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, "The objet \(String(describing: object)) should have been deallocated from memory", file: file, line: line)
        }
    }
}
