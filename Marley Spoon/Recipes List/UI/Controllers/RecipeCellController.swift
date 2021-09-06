//
//  RecipeCellController.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

protocol RecipeCellControllerDelegate {
    func didRequestImage()
}

final class RecipeCellController: RecipeView {
    
    private let delegate: RecipeCellControllerDelegate
    private var cell: RecipeCell?
    private let onSelect: () -> Void
    
    init(delegate: RecipeCellControllerDelegate, onSelect: @escaping () -> Void) {
        self.delegate = delegate
        self.onSelect = onSelect
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        delegate.didRequestImage()
        return cell!
    }
    
    func didSelect() {
        onSelect()
    }
    
    func preload() {
        delegate.didRequestImage()
    }
    
    func cancelLoad() {
        releaseCellForReuse()
    }
    
    func display(_ viewModel: RecipeViewModel) {
        cell?.recipeTitleLabel.text = viewModel.title
        cell?.recipeImageView.image = viewModel.image
        viewModel.isLoading ? cell?.spinner.startAnimating() : cell?.spinner.stopAnimating()
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
    
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
