//
//  Product.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 27/06/2019.
//

import Foundation

public struct Product: Codable {
    var id_product: Int
    var product_name: String
    var price: Int
    var quantity: Int = 1
}
