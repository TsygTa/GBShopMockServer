//
//  BasketController.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 03/07/2019.
//

import Foundation
import PerfectHTTP

/// Контроллер для формирования ответов по запросам о корзине пользователя
public class BasketController {
    
    let addToBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_product = request.param(name: "id_product"),
                let quantityParameter = request.param(name: "quantity") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        
        do {
            print("AddToBasketRequest")
            if let productId = Int(id_product), productId > 0,
                    let quantity = Int(quantityParameter), quantity > 0 {
                
                try response.setBody(json:["result": 1])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong product id or quantity of products"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let deleteFromBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_product = request.param(name: "id_product") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        
        do {
            print("DeleteFromBasketRequest")
            if let productId = Int(id_product), productId > 0 {
                
                try response.setBody(json:["result": 1])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong product id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let payment: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_user = request.param(name: "id_user") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        do {
            print("PaymentRequest")
            if let userId = Int(id_user), userId > 0 {
                
                try response.setBody(json:["result": 1, "userMessage": "Оплата прошла успешно"])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong user id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
}