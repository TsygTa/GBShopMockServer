//
//  GoodsListResponse.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation

struct GoodsListResponse: Codable {
    var result: Int
    var goods: [Product]
}
