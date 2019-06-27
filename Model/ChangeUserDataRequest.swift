//
//  ChangeUserDataRequest.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation

struct ChangeUserDataRequest {
    var id_user: Int = 0
    var username: String = ""
    var password: String = ""
    var email: String = ""
    var gender: String = ""
    var credit_card: String = ""
    var bio: String = ""
    
    init(_ json: [String: AnyObject]) {
        if let id_user = json["id_user"] as? Int {
            self.id_user = id_user
        }
        if let username = json["username"] as? String {
            self.username = username
        }
        if let password = json["password"] as? String {
            self.password = password
        }
        if let email = json["email"] as? String {
            self.email = email
        }
        if let gender = json["gender"] as? String {
            self.gender = gender
        }
        if let credit_card = json["credit_card"] as? String {
            self.credit_card = credit_card
        }
        if let bio = json["bio"] as? String {
            self.bio = bio
        }
    }
}
