//
//  RecipesListViewController.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

protocol RecipesListViewControllerDelegate {
    func didRequestListRefresh()
}

public final class RecipesListViewController: UITableViewController, UITableViewDataSourcePrefetching, ListLoadingView {
    var delegate: RecipesListViewControllerDelegate?
    
    var tableModel = [RecipeCellController]() {
        didSet { tableView.reloadData() }
    }
    
    convenience init(delegate: RecipesListViewControllerDelegate) {
        self.init()
        self.delegate = delegate
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.register(RecipeCell.self, forCellReuseIdentifier: String(describing: RecipeCell.self))
        refresh()
    }
    
    @objc
    private func refresh() {
        delegate?.didRequestListRefresh()
    }
    
    func display(isLoading: Bool) {
        isLoading ? refreshControl?.beginRefreshing() : refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableModel[indexPath.row].view(in: tableView)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            tableModel[indexPath.row].preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableModel[indexPath.row].didSelect()
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        tableModel[indexPath.row].cancelLoad()
    }

}
