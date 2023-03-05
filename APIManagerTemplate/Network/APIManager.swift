//
//  APIManager.swift
//  APIManagerTemplate
//
//  Created by Balashekar Vemula on 23/02/23.
//

import Foundation

final class APIManager:APIManagerProtocol{
    
    //Async method
    @available(iOS 15, *)
    func getDecodaleDataAsync<D: Decodable>(from endpoint: Endpoint,with responseModel: D.Type) async -> Result<D, RequestError>{
        do {
            let request = try createRequest(from: endpoint)
            debugPrint("sending request: \(request)")
            
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    //Normal Generic Method
    func getDecodaleData<D>(from endpoint: Endpoint, with responseModel: D.Type, completion: @escaping Handler<D>) where D : Decodable {
        
        //        var urlComponents = URLComponents()
        //        urlComponents.scheme = endpoint.scheme
        //        urlComponents.host = endpoint.host
        //        urlComponents.path = endpoint.path
        //
        //        guard let url = urlComponents.url else {
        //            completion(.failure(.invalidURL))
        //            return
        //        }
        //        var request = URLRequest(url: url)
        //        request.httpMethod = endpoint.method.rawValue
        //        request.allHTTPHeaderFields = endpoint.header
        //
        //        if let bodyParameters = endpoint.body {
        //            request.httpBody = try? JSONEncoder().encode(bodyParameters)
        //        }
        do {
            let request = try createRequest(from: endpoint)
            debugPrint("sending request: \(request)")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      200 ... 299 ~= response.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let resultData = try JSONDecoder().decode(responseModel, from: data)
                    completion(.success(resultData))
                }catch {
                    completion(.failure(.decode))
                }
                
            }.resume()
        } catch let error {
            debugPrint(error)
        }
        
        
        
    }
}

extension APIManager{
    func createRequest(from endpoint: Endpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        
        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }
        if let parameters = endpoint.parameters {
            debugPrint("sending parameters: \(parameters)")
            urlComponents.queryItems = parameters
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        //        if let body = endpoint.body {
        //            debugPrint("sending body: \(body)")
        //            let check = JSONSerialization.isValidJSONObject(body)
        //            if check == true{
        //                debugPrint("isValidJSONObject = \(check)")
        //                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        //            }else{
        //                debugPrint("isValidJSONObject = \(check)")
        //            }
        //
        //        }
        return request
    }
}
