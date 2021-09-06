//
//  RemoteRecipesListLoader.swift
//  Marley Spoon
//
//  Created by Tulio de Oliveira Parreiras on 06/09/21.
//

import Foundation
import Contentful

final class RemoteRecipesListLoader: RecipesListLoader {
    
    private let url: URL
    private let client: Client
    
    init(url: URL, client: Client) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (RecipesListLoader.Result) -> Void) {
        client.fetch(url: url) { result in
            switch result {
            case let .success(data):
                completion(Result {
                    let response = try JSONDecoder().decode(RecipesResponse.self, from: data)
                    
                    return response.items.compactMap {
                        
                        let tagsIds = $0.fields?.tags?.map { $0.sys.id }
                        let chefsIds = $0.fields?.chef?.sys.id
                        
                        return RecipeModel(title: $0.fields?.title ?? "",
                                           description: $0.fields?.description ?? "",
                                           calories: $0.fields?.calories ?? 0,
                                           tags: response.tags(from: tagsIds),
                                           imageId: $0.fields?.photo?.sys.id,
                                           chefName: response.chef(from: chefsIds)) }
                })
            case let .failure(error):
                completion(.failure(error))
                print(error)
            }
        }
    }
}

extension RecipesResponse {
    func chef(from id: String?) -> String? {
        includes.entry.first { $0.sys?.id == id }?.fields?.name
    }
    
    func tags(from ids: [String?]?) -> [String]? {
        includes.entry.filter { (ids?.contains($0.sys?.id) ?? false) }.compactMap { $0.fields?.name }
    }
}

struct RecipesResponse: Decodable {
    let includes: Included
    let items: [Item]
    
    struct Included: Decodable {
        let assets: [Photo]
        let entry: [Entry]
        
        enum CodingKeys: String, CodingKey {
            case assets = "Asset"
            case entry = "Entry"
        }
        
        struct Photo: Decodable {
            let fields: Fields?
            let sys: Sys?
            
            struct Fields: Decodable {
                let file: File?
                
                struct File: Decodable {
                    let url: String?
                }
            }
        }
        
        struct Entry: Decodable {
            let fields: Fields?
            let sys: Sys?
            
            struct Fields: Decodable {
                let name: String
            }
            struct Sys: Decodable {
                let id: String
            }
        }
        
        struct Sys: Decodable {
            let id: String?
        }
    }
    
    struct Item: Decodable {
        let fields: Fields?
        
        struct Fields: Decodable {
            let calories: Int?
            let description: String?
            let title: String?
            let photo: Field?
            let chef: Field?
            let tags: [Field]?
            
            struct Field: Decodable {
                let sys: Sys
                
                struct Sys: Decodable {
                    let id: String?
                }
            }
            
            
        }
    }
    
}

