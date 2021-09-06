//
//  RecipesListViewController.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

public final class RecipesListViewController: UITableViewController {
    
    public var recipesLoader: RecipesListLoader?
    private var tableModel = [RecipeModel]() { didSet { tableView.reloadData() }}
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RecipeCell.self, forCellReuseIdentifier: String(describing: RecipeCell.self))
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        title = "Recipes List"
        refresh()
    }
    
    @objc
    private func refresh() {
        display(isLoading: true)
        recipesLoader?.load { result in
            self.tableModel = (try? result.get()) ?? []
            self.display(isLoading: false)
        }
    }
    
    func display(isLoading: Bool) {
        isLoading ? refreshControl?.beginRefreshing() : refreshControl?.endRefreshing()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self)) as! RecipeCell
        cell.recipeTitleLabel.text = tableModel[indexPath.row].title
        return cell
    }
    
}
