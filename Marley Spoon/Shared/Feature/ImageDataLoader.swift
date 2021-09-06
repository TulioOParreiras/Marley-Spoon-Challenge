//
//  ImageDataLoader.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import UIKit

public protocol ImageDataLoader {
    typealias Result = Swift.Result<UIImage, Error>
    
    func loadImageData(forImageId imageId: String, completion: @escaping (Result) -> Void)
}
