//
//  ModelFile.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/10/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation

struct BaseModel: Codable {
    let rows: [CanadaModel]
}

class CanadaModel: Codable {
    var title: String?
    var description: String?
    var imagehref: String?
    var image: Data?
    enum CanadaModel: String, CodingKey {
        case title = "title"
        case description = "description"
        case imagehref = "imageHref"
    }
    init(title: String?, description: String?, imagehref: String?) {
        self.title = title
        self.description = description
        self.imagehref = imagehref
    }
}
