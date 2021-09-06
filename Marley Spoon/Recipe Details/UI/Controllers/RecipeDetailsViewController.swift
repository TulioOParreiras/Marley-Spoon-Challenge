//
//  RecipeDetailsViewController.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

public protocol RecipeDetailsViewControllerDelegate {
    func didRequestLoadImage()
}

public final class RecipeDetailsViewController: UIViewController, DetailsView, DetailsImageView, DetailsLoadingView {
    
    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let caloriesLabel = UILabel()
    public let chefLabel = UILabel()
    public let tagsLabel = UILabel()
    public let descriptionLabel = UILabel()
    public let spinner = UIActivityIndicatorView()
    
    public var model: RecipeModel?
    public var imageLoader: ImageDataLoader?
    
    public var delegate: RecipeDetailsViewControllerDelegate?
    
    public convenience init(delegate: RecipeDetailsViewControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.didRequestLoadImage()
    }
    
    func display(isLoading: Bool) {
        isLoading ? spinner.startAnimating() : spinner.stopAnimating()
    }
    
    func display(image: UIImage?) {
        imageView.image = image
    }

    func display(_ viewModel: RecipeDetailsViewModel) {
        titleLabel.text = viewModel.title
        caloriesLabel.text = viewModel.calories
        chefLabel.text = viewModel.chef
        tagsLabel.text = viewModel.tags
        descriptionLabel.text = viewModel.description
    }
    
}
