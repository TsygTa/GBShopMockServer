//
//  AuthController.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation
import PerfectHTTP

class AuthController {
    let register: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let str = request.postBodyString, let data = str.data(using: .utf8) else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            let registerRequest = RegisterRequest(json)
            print("Request - \(registerRequest)")
            try response.setBody(json:["result": 1, "userMessage": "Регистация прошла успешно"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let login: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let username = request.param(name: "username"),
            let password = request.param(name: "password") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
            return
        }
        
        do {
            print("LoginRequest")
            if username == "Somebody", password == "mypassword" {
                var user = User(
                    id_user: 123,
                    user_login: "test",
                    user_name: "Ivan",
                    user_lastname: "Ivanov")
                var loginResponse = LoginResponse(result: 1, user: user)
                
                try response.setBody(json: loginResponse)
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong user name or password"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let logout: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_user = request.param(name: "id_user") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
                return
        }
        
        do {
            if let userId = Int(id_user), userId > 0 {
                try response.setBody(json: ["result": 1])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong user id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
}
