//
//  MainQueueDispatchDecorator.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatchDecorator: RecipesListLoader where T == RecipesListLoader {
    
    func load(completion: @escaping (RecipesListLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
    
}

extension MainQueueDispatchDecorator: ImageDataLoader where T == ImageDataLoader {
    
    func loadImageData(forImageId imageId: String, completion: @escaping (ImageDataLoader.Result) -> Void) {
        decoratee.loadImageData(forImageId: imageId) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
    
}
