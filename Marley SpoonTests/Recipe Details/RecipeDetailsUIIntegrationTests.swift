//
//  RecipeDetailsUIIntegrationTests.swift
//  Marley SpoonTests
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import XCTest

final class RecipeDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
    }
    
}

final class RecipeDetailsUIIntegrationTests: XCTestCase {
    
    func test_view_hasTitle() {
        let sut = RecipeDetailsViewController()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Recipe Details")
    }


}
