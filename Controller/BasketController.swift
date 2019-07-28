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
    
    let getBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let userId = request.param(name: "userId") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        do {
            print("GetBasketRequest")
            if let user_id = Int(userId),
                let basket = Session.instance.baskets.filter({$0.userId == user_id}).first {
                try response.setBody(json: basket)
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong user id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let addToBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard
            let id_user = request.param(name: "id_user"),
            let id_product = request.param(name: "id_product"),
                let quantityParameter = request.param(name: "quantity") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        
        do {
            print("AddToBasketRequest")
            if let userId = Int(id_user),
                let basketIndex = Session.instance.baskets.firstIndex(where: {$0.userId == userId}) {
                if let productId = Int(id_product),
                    let quantity = Int(quantityParameter), quantity > 0,
                    var product = (Session.instance.productsCatalog
                        .filter{$0.id_product == productId}).first {
                    let basket = Session.instance.baskets[basketIndex]
                    product.quantity = quantity
                    if let productIndex = basket.products.firstIndex(where: {$0.id_product == productId}), productIndex >= 0 {
                        Session.instance.baskets[basketIndex].products[productIndex].quantity = product.quantity
                    } else {
                        Session.instance.baskets[basketIndex].products.append(product)
                    }
                    try response.setBody(json:["result": 1])
                } else {
                    try response.setBody(json:["result": 0, "errorMessage": "Wrong product id or quantity of products"])
                }
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong user id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let deleteFromBasket: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_user = request.param(name: "id_user"),
            let productId = request.param(name: "id_product") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        
        do {
            print("DeleteFromBasketRequest")
            if let userId = Int(id_user),
                let basketIndex = Session.instance.baskets.firstIndex(where: {$0.userId == userId}),
                let id = Int(productId), id >= 0 {
                Session.instance.baskets[basketIndex].products = Session.instance.baskets[basketIndex].products.filter{$0.id_product != id}
                try response.setBody(json:["result": 1])
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong request parameters"])
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
            if let userId = Int(id_user),
                let basketIndex = Session.instance.baskets.firstIndex(where: {$0.userId == userId}) {
                Session.instance.baskets[basketIndex].isPaid = true
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
