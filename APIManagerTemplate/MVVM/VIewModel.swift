//
//  VIewModel.swift
//  APIManagerTemplate
//
//  Created by Balashekar Vemula on 05/03/23.
//

import Foundation
final class ViewModel{
    
    let service: APIManagerProtocol
    var eventHandler: ((_ event: Event) -> Void)?
    
    var modelResponse:[ProductDataModel]?
    var addProductResponseModel:AddProductResponseModel?
    var loginResponse:LoginDataModel?
    var cartResponse:[CartResponseDataModel]?
    var addToCartResponse:AddToCartResponseModel?
    
    
    init(service: APIManagerProtocol = APIManager()) {
        self.service = service
    }
    //normal fetch
    func getData(){
        self.eventHandler?(.loading)
        service.getDecodaleData(from: APIEndpoint.getAllProducts, with: [ProductDataModel].self) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let response):
                self.modelResponse = response
                debugPrint("got normal api call response")
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
                debugPrint(error)
            }
        }
    }
    //async/await fetch
    @available(iOS 15, *)
    func fetchData() {
        Task{
            let result = await service.getDecodaleDataAsync(from: APIEndpoint.getAllProducts, with: [ProductDataModel].self)
            switch result {
            case .success(let response):
                modelResponse = response
                //                debugPrint("got modelResponse")
                debugPrint("got async api call response")
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    //sending params to body example
    
    @available(iOS 15, *)
    func addPoduct(bodyParms:AddProductRequestModel){
        Task{
            let result = await service.getDecodaleDataAsync(from: APIEndpoint.addProduct(bodyParms: bodyParms), with: AddProductResponseModel.self)
            switch result {
            case .success(let response):
                addProductResponseModel = response
                debugPrint("got addProductResponseModel")
            case .failure(let error):
                debugPrint(error.customMessage)
            }
        }
    }
    @available(iOS 15, *)
    func loginUser(bodyParms:LoginRequstModel){
        Task{
            let result = await service.getDecodaleDataAsync(from: APIEndpoint.login(bodyParms: bodyParms), with: LoginDataModel.self)
            switch result {
            case .success(let response):
                loginResponse = response
                debugPrint("got loginResponse")
            case .failure(let error):
                debugPrint(error.customMessage)
            }
        }
    }
    @available(iOS 15, *)
    func addToCart(bodyParms:AddToCartRequstModel){
        Task{
            let result = await service.getDecodaleDataAsync(from: APIEndpoint.addToCart(bodyParms: bodyParms), with: AddToCartResponseModel.self)
            switch result {
            case .success(let response):
                addToCartResponse = response
                debugPrint("got addToCartResponse")
            case .failure(let error):
                debugPrint(error.customMessage)
            }
        }
    }
    //sending params to urlqueryItems example
    @available(iOS 15, *)
    func getCartItems(with limit:String){
        Task{
            let result = await service.getDecodaleDataAsync(from: APIEndpoint.cart(limit: limit), with: [CartResponseDataModel].self)
            switch result {
            case .success(let response):
                cartResponse = response
                debugPrint("got cartResponse")
            case .failure(let error):
                debugPrint(error.customMessage)
            }
        }
    }
    
}
