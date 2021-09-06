//
//  SceneDelegate.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit
import Contentful

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let spaceId = "kk2bw5ojx476"
    private let environmentId = "master"
    private let accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    
    private lazy var client = Client(spaceId: spaceId, environmentId: environmentId, accessToken: accessToken)
    private lazy var imageLoader = RemoteImageDataLoader(client: client)
 
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        guard let url = makeURL() else { return }
        window = UIWindow(windowScene: windowScene)
        let recipesLoader = RemoteRecipesListLoader(url: url,
                                                    client: client)
        let controller = RecipesListUIComposer.recipesListComposedWith(recipesLoader: recipesLoader,
                                                                       imageLoader: imageLoader,
                                                                       onSelect: onSelect(_:))
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
    }
    
    private func makeURL() -> URL? {
        URL(string: "https://cdn.contentful.com/spaces/\(spaceId)/environments/\(environmentId)/entries?access_token=\(accessToken)&content_type=recipe")
    }
    
    private func onSelect(_ model: RecipeModel) {
        let detailsController = RecipeDetailsUIComposer.recipeDetailsComposedWith(imageLoader: imageLoader, recipeModel: model)
        (self.window?.rootViewController as? UINavigationController)?.pushViewController(detailsController, animated: true)
     }

}

