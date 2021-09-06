//
//  RecipeDetailsViewController.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

public final class RecipeDetailsViewController: UIViewController {
    
    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let caloriesLabel = UILabel()
    public let chefLabel = UILabel()
    public let tagsLabel = UILabel()
    public let descriptionLabel = UILabel()
    public let spinner = UIActivityIndicatorView()
    
    public var model: RecipeModel?
    public var imageLoader: ImageDataLoader?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
        
        spinner.startAnimating()
        if let imageId = model?.imageId {
            imageLoader?.loadImageData(forImageId: imageId, completion: { result in
                self.spinner.stopAnimating()
                self.imageView.image = try? result.get()
            })
        }
        
        guard let model = model else { return }
        titleLabel.text = model.title
        caloriesLabel.text = "Calories: \(model.calories)"
        chefLabel.text = "Chef: " + (model.chefName ?? "-")
        tagsLabel.text = tagsText(fromTags: model.tags)
        descriptionLabel.text = model.description
    }
    
    private func tagsText(fromTags tags: [String]?) -> String {
        guard let tags = tags, !tags.isEmpty else { return "Tags: -" }
        var tagsText = tags.reduce("", { return $0 + $1 + ", " })
        tagsText.removeLast()
        tagsText.removeLast()
        return "Tags: " + tagsText
    }
    
}
