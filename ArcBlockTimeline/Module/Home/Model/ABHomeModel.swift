//
//  ABHomeModel.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import Foundation
import ObjectMapper

enum ContentType: String {
    case img        = "image"
    case text       = "text"
    case textImage  = "text-image"
    case textLink   = "text-link"
}

struct ABHomeModel: Mappable {
    var id = 0
    var type = ContentType.text
    
    var text = ""
    var images: [String] = []
    var link = ""
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id     <- map["id"]
        type   <- (map["type"], EnumTransform<ContentType>())
        text   <- map["content"]
        images <- map["imgUrls"]
        link   <- map["link"]
    }
}
