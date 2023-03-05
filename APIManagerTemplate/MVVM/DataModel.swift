//
//  DataModel.swift
//  APIManagerTemplate
//
//  Created by Balashekar Vemula on 05/03/23.
//

import Foundation
struct ProductDataModel: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Decodable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Decodable {
    let rate: Double
    let count: Int
}

// MARK: - Add product Data Model

struct AddProductRequestModel: Codable {
    let title: String?
    let price: Int?
    let description: String?
    let image: String?
    let category: String?
}
struct AddProductResponseModel: Codable {
    let id: Int?
    let title: String?
    let price: Int?
    let description: String?
    let image: String?
    let category: String?
}
// MARK: - Login Data Model
struct LoginRequstModel: Codable {
    let username, password: String?
}
struct LoginDataModel:Decodable {
    let token: String?
}

// MARK: - CartResponse Data Model

struct CartResponseDataModel: Decodable {
    let id, userID: Int?
    let date: String?
    let products: [Product]?
    let v: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case date, products
        case v = "__v"
    }
}

struct Product: Decodable {
    let productID, quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}


// MARK: - AddToCart Data Model

struct AddToCartRequstModel: Codable {
    let userID: Int?
    let date: String?
    let products: [AddToCartRequstModelProduct]?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case date, products
    }
}

struct AddToCartRequstModelProduct: Codable {
    let productID, quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}
struct AddToCartResponseModel: Codable {
    let id, userID: Int?
    let date: String?
    let products: [AddToCartResponseProduct]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case date, products
    }
}

struct AddToCartResponseProduct: Codable {
    let productID, quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}
