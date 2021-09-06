//
//  RecipeModel.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

public struct RecipeModel {
    public let title: String
    public let description: String
    public let calories: Int
    public let tags: [String]?
    public let imageId: String?
    public let chefName: String?
    
    public init(title: String, description: String, calories: Int, tags: [String]?, imageId: String?, chefName: String?) {
        self.title = title
        self.description = description
        self.calories = calories
        self.tags = tags
        self.imageId = imageId
        self.chefName = chefName
    }
}
