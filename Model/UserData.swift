//
//  UserData.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 30/06/2019.
//

import Foundation

struct UserData: Codable {
    let id: Int
    var email: String
    var gender: String
    var creditCard: String
    var bio: String
}
