//
//  RecipesListLoader.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

public protocol RecipesListLoader {
    typealias Result = Swift.Result<Void, Error>
    
    func load(completion: @escaping (Result) -> Void)
}
