//
//  RecipesListViewController.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

public final class RecipesListViewController: UITableViewController {
    
    public var recipesLoader: RecipesListLoader?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        title = "Recipes List"
        refresh()
    }
    
    @objc
    private func refresh() {
        display(isLoading: true)
        recipesLoader?.load {
            _ in
            self.display(isLoading: false)
        }
    }
    
    func display(isLoading: Bool) {
        isLoading ? refreshControl?.beginRefreshing() : refreshControl?.endRefreshing()
    }
    
}
