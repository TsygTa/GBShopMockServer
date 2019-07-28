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
            var user = registerRequest.user
            
            if Session.instance.users.filter({$0.login == user.login}).first != nil {
                try response.setBody(json:["result": 0, "userMessage": "Пользователь с таким логином уже зарегистрирован"])
            } else {
                print("Request - \(registerRequest)")
                
                var lastId = 1
                if let lastUser = Session.instance.users.last {
                    lastId = lastUser.id + 1
                }
                user.id = lastId
                Session.instance.users.append(user)
                
                var lastBasketId = 1
                if let lastBasket = Session.instance.baskets.last {
                    lastBasketId = lastBasket.id + 1
                }
                Session.instance.baskets.append(Basket(id: lastBasketId,
                                      userId: user.id,
                                      products: [],
                                      isPaid: false))
                
                try response.setBody(json:["result": 1, "userId": user.id, "userMessage": "Регистация прошла успешно"])
            }
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
            let user = changeUserDataRequest.user
            print("Request - \(changeUserDataRequest)")
            
            if let index = Session.instance.users.firstIndex(where: {$0.id == user.id}), index >= 0 {
                Session.instance.users[index] = user
                try response.setBody(json:["result": 1])
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Пользователь не найден"])
            }
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
            if let user = Session.instance.users.filter({$0.login == username && $0.password == password}).first {
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
