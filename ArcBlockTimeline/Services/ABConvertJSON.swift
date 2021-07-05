//
//  ABConvertJSON.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class ABConvertJSON {
    static let shared = ABConvertJSON()
    
    func reload() -> Observable<[ABHomeModel]> {
        guard let path = Bundle.main.path(forResource: "JsonData", ofType: "json") else {
            return Observable.just([])
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return Observable.just([])
            }
            let model = Mapper<BaseModel>().map(JSON: jsonData)
            
            guard let arr = Mapper<ABHomeModel>().mapArray(JSONObject: model?.data) else {
                return Observable.just([])
            }
            
            return Observable.just(arr)
        } catch {
            print(error)
        }
        
        return Observable.just([])
    }
}
