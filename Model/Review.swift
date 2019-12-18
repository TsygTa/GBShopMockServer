//
//  Review.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 30/06/2019.
//

import Foundation

struct Review: Codable {
    var id: Int
    var userId: Int?
    var productId: Int
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case productId
        case text
    }
}
