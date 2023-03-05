//
//  Protocols.swift
//  APIManagerTemplate
//
//  Created by Balashekar Vemula on 05/03/23.
//

import Foundation
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
    var parameters: [URLQueryItem]? { get }
}
extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "fakestoreapi.com"
    }
}

typealias Handler<T> = (Result<T, RequestError>) -> Void

protocol APIManagerProtocol {
    @available(iOS 15, *)
    func getDecodaleDataAsync<D: Decodable>(from endpoint: Endpoint,with responseModel: D.Type) async  -> Result<D, RequestError>
    func getDecodaleData<D: Decodable>(from endpoint: Endpoint,with responseModel: D.Type,completion: @escaping Handler<D>)
}
