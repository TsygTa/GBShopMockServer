//
//  LoginResponse.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation

struct LoginResponse: Codable {
    var result: Int
    var user: User?
    var errorMessage: String?
}
