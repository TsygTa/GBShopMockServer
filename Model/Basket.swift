//
//  Basket.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 18/07/2019.
//

import Foundation
public struct Basket: Codable {
    var id: Int
    var userId: Int
    var products: [Product]
    var isPaid: Bool
}
