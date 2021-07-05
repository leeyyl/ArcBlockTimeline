//
//  BaseModel.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseModel: Mappable {
    var msg = ""
    var code = 0
    var data: [Any] = []
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        msg  <- map["msg"]
        code <- map["code"]
        data <- map["data"]
    }
}
