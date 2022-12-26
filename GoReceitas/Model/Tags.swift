//
//  Tags.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/12/22.
//

import Foundation

struct Tags: Codable {
    var results: [TagsResponse]
}

struct TagsResponse: Codable {
    let id: Int
    let type: String
    let name: String
    let display_name: String
}
