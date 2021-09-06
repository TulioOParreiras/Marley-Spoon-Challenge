//
//  RecipeModel.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

public struct RecipeModel {
    let title: String
    let description: String
    let calories: Int
    let tags: [String]?
    let imageId: String?
    let chefName: String?
}
