//
//  GoodsController.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 27/06/2019.
//

import Foundation
import PerfectHTTP

/// Контроллер для формирования ответов по запросам о товарах
public class GoodsController {
    
    let goodsList: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let page_number = request.param(name: "page_number"),
            let id_category = request.param(name: "id_category") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        
        do {
            print("GoodsListRequest")
            if let page = Int(page_number), page > 0,
                let categoryId = Int(id_category), categoryId > 0 {
                var goods: [Product] = []
                goods.append(Product(id_product: 123,
                    product_name: "Ноутбук",
                    price: 45600
                ))
                goods.append(Product(
                    id_product: 456,
                    product_name: "Мышка",
                    price: 1000
                ))
                
                let goodsListResponse = GoodsListResponse(page_number: 1, products: goods)
                try response.setBody(json: goodsListResponse)
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong page or id_category"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let goodById: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_product = request.param(name: "id_product") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        
        do {
            print("GoodByIdRequest")
            if let productId = Int(id_product), productId > 0 {
                let good = GoodByIdResponse(result: 1,
                                            product_name: "Товар",
                                            product_price: 123,
                                            product_description: "Описание")
                
                try response.setBody(json: good)
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong product id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
}
