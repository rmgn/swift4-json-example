//
//  Rows.swift
//  swiftlearning
//
//  Created by Ranjith Karuvadiyil on 31/01/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import Foundation

struct Rows {
    let title: String
    let description: String
    let imageHref: String
}

extension Rows: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let titleValue = try values.decodeIfPresent(String.self, forKey: .title){
            title = titleValue
        }else{
            title = ""
        }
        if let url = try values.decodeIfPresent(String.self, forKey: .description) {
            // do your textView function
            description = url
        } else {
            // handle nil url
            description = ""
        }
        
        if let imageName = try values.decodeIfPresent(String.self, forKey: .imageHref){
            imageHref = imageName
        }else{
            imageHref = ""
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(imageHref, forKey: .imageHref)
    }
}
