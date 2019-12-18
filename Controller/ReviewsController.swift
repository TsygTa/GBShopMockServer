//
//  ReviewsController.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 30/06/2019.
//

import Foundation
import PerfectHTTP

/// Контроллер формирования ответов на запросы по Отзывам пользователей о товарах
public class ReviewsController {
    
    let reviewsList: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let page_number = request.param(name: "page"),
                let productId = request.param(name: "productId") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        
        do {
            print("ReviewsListRequest")
            if let page = Int(page_number), page > 0,
                let product = Int(productId), product > 0 {
                
                let filtered = Session.instance.reviews.filter{$0.productId == product}
                
                let reviwsListResponse = ReviewsListResponse(page: 1, reviews: filtered)
                try response.setBody(json: reviwsListResponse)
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong page number or product ID"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let addReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let user = request.param(name: "id_user"),
                let product = request.param(name: "id_product"),
                let text = request.param(name: "text") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        
        do {
            print("AddReviewRequest")
            if let userId = Int(user), userId > 0,
                let productId = Int(product), productId > 0,
                !text.isEmpty {
                
                var lastId = 1
                
                if let review = Session.instance.reviews.last {
                    lastId = review.id + 1
                }
                Session.instance.reviews.append(Review(id: lastId,
                                                       userId: userId,
                                                       productId: productId,
                                                       text: text
                ))
                try response.setBody(json:["result": 1, "userMessage": "Ваш отзыв был передан на модерацию"])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong request parameters"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let removeReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let review = request.param(name: "id_comment") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        do {
            print("RemoveReviewRequest")
            if let reviewId = Int(review), reviewId > 0 {
                Session.instance.reviews = Session.instance.reviews.filter{$0.id != reviewId}
                try response.setBody(json:["result": 1])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong review id"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
}
