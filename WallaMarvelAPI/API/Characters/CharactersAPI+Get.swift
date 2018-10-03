//
//  CharactersAPI+Get.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 2/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import Alamofire
import Promises

public extension API.Characters{
    public struct Get{
        private init(){}
    }
}

public extension API.Characters.Get{
    public static func all(filteringBy filter:CharactersFilter? = nil, cursor:Cursor = .firstResults()) -> Promise<CharactersResult>{
        var params = API.Keys.Marvel.asParams()
        if let cursorParams = try? CursorMappingEntity(entity: cursor).asJSON(){
            params.merge(cursorParams, uniquingKeysWith: { current, _ in current })
        }
        if let filter = filter, let charactersFilterParams = try? CharactersFilterMappingEntity(entity: filter).asJSON(){
            params.merge(charactersFilterParams, uniquingKeysWith: { current, _ in current})
        }
        
        return Promise{ fulfill, reject in
            Alamofire.request(API.Endpoints.Marvel.characters, method: .get, parameters: params).responseJSON { (response:DataResponse<Any>) in
                guard response.result.isSuccess else{
                    reject(response.result.error!)
                    return
                }
                
                guard let JSON = response.result.value! as? [String:Any],
                    let data = JSON["data"] as? [String:Any],
                    let dataResult = try? DataResultMappingEntity(from: data).asEntity else {
                    reject(RequestError.responseNotConsistent)
                    return
                }

                let nextCursor = Cursor(offset: dataResult.offset + dataResult.limit, limit: dataResult.limit)
                let characters = dataResult.results.map{ return try? CharacterMappingEntity(from: $0).asEntity }.filteringNils() // If some character is corrupted, we just ignore it
                let result = CharactersResult(nextCursor: nextCursor, characters: characters)
                fulfill(result)
            }
        }
    }
}

public extension API.Characters.Get{
    public struct CharactersResult{
        public let nextCursor:Cursor
        public let characters:[Character]
    }
}
