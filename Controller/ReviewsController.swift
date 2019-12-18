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
                var reviews: [Review] = []
                reviews.append(Review(id: 57,
                                     userId: 123,
                                     productId: 123,
                                     text: "Отзыв пользователя 57"
                ))
                reviews.append(Review(id: 80,
                                     userId: 567,
                                     productId: 123,
                                     text: "Отзыв пользователя 80"
                ))
                
                reviews.append(Review(id: 33,
                                      userId: 77,
                                      productId: 456,
                                      text: "Отзыв пользователя 80"
                ))
                reviews.append(Review(id: 45,
                                      userId: 567,
                                      productId: 456,
                                      text: "Отзыв пользователя 567"
                ))
                reviews.append(Review(id: 44,
                                      userId: 568,
                                      productId: 456,
                                      text: "Отзыв пользователя 568"
                ))
                
                let filtered = reviews.filter{$0.productId == product}
                
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
        guard let user = request.param(name: "userId"),
                let text = request.param(name: "text") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        
        do {
            print("AddReviewRequest")
            if let userId = Int(user), userId > 0,
                !text.isEmpty {
                try response.setBody(json:["result": 1, "userMessage": "Ваш отзыв был передан на модерацию"])
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong review id or text"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let removeReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let review = request.param(name: "id") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        do {
            print("RemoveReviewRequest")
            if let reviewId = Int(review), reviewId > 0 {
                
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
