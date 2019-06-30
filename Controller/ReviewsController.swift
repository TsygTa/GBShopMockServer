//
//  ReviewsController.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 30/06/2019.
//

import Foundation
import PerfectHTTP

class ReviewsController {
    
    let reviewsList: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let page_number = request.param(name: "page_number") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        
        do {
            print("ReviewsListRequest")
            if let page = Int(page_number), page > 0 {
                var reviews: [Review] = []
                reviews.append(Review(id_comment: 57,
                                     id_user: 123,
                                     text: "Отзыв пользователя 57"
                ))
                reviews.append(Review(id_comment: 80,
                                     id_user: 567,
                                     text: "Отзыв пользователя 80"
                ))
                
                let reviwsListResponse = ReviewsListResponse(page_number: 1, reviews: reviews)
                try response.setBody(json: reviwsListResponse)
                
            } else {
                try response.setBody(json:["result": 0, "errorMessage": "Wrong page number"])
            }
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let addReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
        guard let id_user = request.param(name: "id_user"),
                let text = request.param(name: "text") else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
            return
        }
        
        do {
            print("AddReviewRequest")
            if let userId = Int(id_user), userId > 0,
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
        guard let id_comment = request.param(name: "id_comment") else {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong request parameters"))
                return
        }
        do {
            print("RemoveReviewRequest")
            if let reviewId = Int(id_comment), reviewId > 0 {
                
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
