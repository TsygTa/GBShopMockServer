//
//  Session.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 20/07/2019.
//

import Foundation

public class Session {
    
    static let instance = Session()
    var users: [User] = []
    var productsCatalog: [Product] = []
    var reviews: [Review] = []
    var baskets: [Basket] = []
    
    private init() {
        users.append(User(
            id: 1,
            login: "123",
            password: "123",
            email: "775566@mail.ru",
            name: "Ivan",
            lastname: "Ivanov",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: ""))
        productsCatalog.append(Product(
            id_product: 123,
            product_name: "Ноутбук",
            price: 45600,
            description: "Ноутбук - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 456,
            product_name: "Мышка",
            price: 1000,
            description: "Мышка - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 78,
            product_name: "Принтер",
            price: 35000,
            description: "Принтер - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 90,
            product_name: "Бумага А4",
            price: 300,
            description: "Бумага А4 - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 91,
            product_name: "Клавиатура",
            price: 5000,
            description: "Клавиатура - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 92,
            product_name: "Компьютер",
            price: 50000,
            description: "Компьтер - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 93,
            product_name: "Роутер",
            price: 3000,
            description: "Роутер - описание",
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 94,
            product_name: "Сканер",
            price: 20000,
            description: "Сканер - описание",
            quantity: 1
        ))
        
        baskets.append(Basket(id: 1,
                        userId: 1,
                        products: [],
                        isPaid: false))
        
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
    }
}
