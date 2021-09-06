//
//  RecipesListsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest

import UIKit

final class RecipesListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes List"
    }
    
}

class RecipesListsUIIntegrationTests: XCTestCase {

    func test_view_hasTitle() {
        let sut = RecipesListViewController()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Recipes List")
    }

}
