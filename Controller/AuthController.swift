//
//  AuthController.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 26/06/2019.
//

import Foundation
import PerfectHTTP

/// Контроллер для формирования ответов по запросам на авторизацию,
/// регистрацию и изменение данных пользователя
public class AuthController {
    let registerUser: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let str = request.postBodyString, let data = str.data(using: .utf8) else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
            return
        }
        
        do {
            print("RegisterUserRequest")
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            let registerRequest = RegisterRequest(json)
            print("Request - \(registerRequest)")
            try response.setBody(json:["result": 1, "userMessage": "Регистация прошла успешно"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let changeUserData: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let str = request.postBodyString, let data = str.data(using: .utf8) else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
            return
        }
        
        do {
            print("ChangeUserDataRequest")
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            let changeUserDataRequest = ChangeUserDataRequest(json)
            print("Request - \(changeUserDataRequest)")
            try response.setBody(json:["result": 1])
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
            if username == "123", password == "123" {
                var user = User(
                    id: 123,
                    login: username,
                    password: username,
                    email: "775566@mail.ru",
                    name: "Ivan",
                    lastname: "Ivanov",
                    gender: "m",
                    creditCard: "9872389-2424-234224-234",
                    bio: "")
                var loginResponse = LoginResponse(result: 1, user: user, errorMessage: nil)
                
                try response.setBody(json: loginResponse)
                
            } else {
                try response.setBody(json:["result": 0, "user": nil,"errorMessage": "Wrong user name or password"])
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
            print("LogoutRequest")
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
