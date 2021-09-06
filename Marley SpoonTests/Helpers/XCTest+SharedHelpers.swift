//
//  XCTest+SharedHelpers.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Marley_Spoon

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
