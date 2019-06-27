//
//  GoodByIdResponse.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation

struct GoodByIdResponse: Codable {
    var result: Int
    var product_name: String
    var product_price: Int
    var product_description: String
}
