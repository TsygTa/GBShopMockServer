//
//  ReviewsListResponse.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 30/06/2019.
//

import Foundation

struct ReviewsListResponse: Codable {
    var page_number: Int
    var reviews: [Review]
}
