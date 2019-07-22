//
//  Session.swift
//  COpenSSL
//
//  Created by Tatiana Tsygankova on 20/07/2019.
//

import Foundation

public class Session {
    
    static let instance = Session()
    var user: User
    var productsCatalog: [Product] = []
    var basket: Basket
    
    private init() {
        user = User(
            id: 123,
            login: "123",
            password: "123",
            email: "775566@mail.ru",
            name: "Ivan",
            lastname: "Ivanov",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "")
        productsCatalog.append(Product(
            id_product: 123,
            product_name: "Ноутбук",
            price: 45600,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 456,
            product_name: "Мышка",
            price: 1000,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 78,
            product_name: "Принтер",
            price: 35000,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 90,
            product_name: "Бумага А4",
            price: 300,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 91,
            product_name: "Клавиатура",
            price: 5000,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 92,
            product_name: "Компьютер",
            price: 50000,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 93,
            product_name: "Роутер",
            price: 3000,
            quantity: 1
        ))
        productsCatalog.append(Product(
            id_product: 94,
            product_name: "Сканер",
            price: 20000,
            quantity: 1
        ))
        basket = Basket(id: 1,
                        userId: 123,
                        products: [],
                        isPaid: false)
    }
}
