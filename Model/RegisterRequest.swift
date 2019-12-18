//
//  RegisterRequest.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation

struct RegisterRequest {
    var user: User = User()
    
    init(_ json: [String: AnyObject]) {
        
        if let user_id = json["id"] as? Int {
            self.user.id = user_id
        }
        if let login = json["login"] as? String {
            self.user.login = login
        }
        if let name = json["name"] as? String {
            self.user.name = name
        }
        if let lastname = json["lastname"] as? String {
            self.user.lastname = lastname
        }
        if let password = json["password"] as? String {
            self.user.password = password
        }
        if let email = json["email"] as? String {
            self.user.email = email
        }
        if let gender = json["gender"] as? String {
            self.user.gender = gender
        }
        if let creditCard = json["creditCard"] as? String {
            self.user.creditCard = creditCard
        }
        if let bio = json["bio"] as? String {
            self.user.bio = bio
        }
    }
}


