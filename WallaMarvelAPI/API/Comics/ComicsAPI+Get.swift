//
//  ComicsAPI+Get.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation
import Alamofire
import Promises
import WallaMarvelKit

public extension API.Comics{
    public struct Get{
        private init(){}
    }
}

public extension API.Comics.Get{
    public static func all(filteringBy filter:ComicsFilter? = nil, cursor:Cursor = .firstResults()) -> Promise<ComicsResult>{
        var params = API.Keys.Marvel.asParams()
        if let cursorParams = try? CursorMappingEntity(entity: cursor).asJSON(){
            params.merge(cursorParams, uniquingKeysWith: { current, _ in current })
        }
        if let filter = filter, let comicsFilterParams = try? ComicsFilterMappingEntity(entity: filter).asJSON(){
            params.merge(comicsFilterParams, uniquingKeysWith: { current, _ in current})
        }
        
        return Promise{ fulfill, reject in
            Alamofire.request(API.Endpoints.Marvel.comics, method: .get, parameters: params).responseJSON { (response:DataResponse<Any>) in
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
                let comics = dataResult.results.map{ return try? ComicMappingEntity(from: $0).asEntity }.filteringNils() // If some comic is corrupted, we just ignore it
                let result = ComicsResult(nextCursor: nextCursor, comics: comics)
                fulfill(result)
            }
        }
    }
    
    public static func byID(_ ID:String) -> Promise<Comic>{
        let params = API.Keys.Marvel.asParams()
        
        return Promise{ fulfill, reject in
            Alamofire.request(API.Endpoints.Marvel.comic.formatted(ID), method: .get, parameters: params).responseJSON { (response:DataResponse<Any>) in
                guard response.result.isSuccess else{
                    reject(response.result.error!)
                    return
                }
                
                guard let JSON = response.result.value! as? [String:Any],
                    let data = JSON["data"] as? [String:Any],
                    let dataResult = try? DataResultMappingEntity(from: data).asEntity,
                    let firstResult = dataResult.results.first,
                    let comic = try? ComicMappingEntity(from: firstResult).asEntity else {
                        reject(RequestError.responseNotConsistent)
                        return
                }
                
                fulfill(comic)
            }
        }
    }
}

public extension API.Comics.Get{
    public struct ComicsResult{
        public let nextCursor:Cursor
        public let comics:[Comic]
    }
}
