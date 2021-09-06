//
//  RemoteImageDataLoader.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation
import Contentful

final class RemoteImageDataLoader: ImageDataLoader {
    
    lazy var query: Query = {
        let query = Query()
        query.parameters["content_type"] = "recipe"
        return query
    }()
    let client: Client
    
    private enum Error: Swift.Error {
        case assetNotFound
    }
    
    init(client: Client) {
        self.client = client
    }
    
    func loadImageData(forImageId imageId: String, completion: @escaping (ImageDataLoader.Result) -> Void) {
        fetchAssets(forImageId: imageId, completion: completion)
    }
    
    private func fetchAssets(forImageId imageId: String, completion: @escaping (ImageDataLoader.Result) -> Void) {
        client.fetchArray(matching: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                if let asset = response.includedAssets?.first(where: { $0.id == imageId }) {
                    self.loadImageFromAsset(asset, completion: completion)
                } else {
                    completion(.failure(Error.assetNotFound))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func loadImageFromAsset(_ asset: Asset, completion: @escaping (ImageDataLoader.Result) -> Void) {
        client.fetchImage(for: asset) { imageR in
            switch imageR {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
