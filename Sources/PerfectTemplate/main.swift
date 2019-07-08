//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
let authController = AuthController()
let goodsController = GoodsController()
let reviewsController = ReviewsController()
let basketController = BasketController()
var routes = Routes()

routes.add(method: .post, uri: "/registerUser", handler: authController.registerUser)
routes.add(method: .post, uri: "/changeUserData", handler: authController.changeUserData)
routes.add(method: .get, uri: "/login", handler: authController.login)
routes.add(method: .get, uri: "/logout", handler: authController.logout)
routes.add(method: .get, uri: "/catalogData", handler: goodsController.goodsList)
routes.add(method: .get, uri: "/getGoodById", handler: goodsController.goodById)
routes.add(method: .get, uri: "/getReviewsList", handler: reviewsController.reviewsList)
routes.add(method: .get, uri: "/addReview", handler: reviewsController.addReview)
routes.add(method: .get, uri: "/removeReview", handler: reviewsController.removeReview)
routes.add(method: .get, uri: "/addToBasket", handler: basketController.addToBasket)
routes.add(method: .get, uri: "/deleteFromBasket", handler: basketController.deleteFromBasket)
routes.add(method: .get, uri: "/payment", handler: basketController.payment)

server.addRoutes(routes)
server.serverPort = 8081

do {
    try server.start()
} catch {
    fatalError("Network error - \(error)")
}
