//
//  ViewController.swift
//  APIManagerTemplate
//
//  Created by Balashekar Vemula on 23/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalFetchAndAsync()
        testingBodyEncode()
        testingURLQueryItems()
        addToCartWithBodyParams()
        addProduct()
    }
    //normal fetch example
    private func normalFetchAndAsync(){
        if #available(iOS 15, *) {
            debugPrint("IOS 15 avilable : calling async api")
            viewModel.fetchData()
        } else {
            // Fallback on earlier versions
            debugPrint("IOS 15 not avilable : calling normal api")
            viewModel.getData()
        }
    }
    
    //encode bodyparams example
    @available(iOS 15, *)
    private func testingBodyEncode(){
        let bodyParms = LoginRequstModel(username: "mor_2314", password: "83r5^_")
        viewModel.loginUser(bodyParms: bodyParms)
    }
    
    @available(iOS 15, *)
    private func addToCartWithBodyParams(){
        let bodyParms = AddToCartRequstModel(userID: 1, date: "2020-02-03", products: [AddToCartRequstModelProduct(productID: 5, quantity: 3)])
        viewModel.addToCart(bodyParms: bodyParms)
    }
    @available(iOS 15, *)
    private func addProduct(){
        let bodyParms = AddProductRequestModel(title: "HP Mouse", price: 349, description: "HP Wired Mouse 100 with 1600 DPI Optical Sensor, USB Plug-and -Play,ambidextrous Design, Built-in Scrolling and 3 Handy Buttons. 3-Years Warranty (6VY96AA)", image: "https://m.media-amazon.com/images/I/71ZqmiRNQjL._SX679_.jpg", category: "electronic")
        viewModel.addPoduct(bodyParms: bodyParms)
    }
    //encode URLQueryItems example
    @available(iOS 15, *)
    private func testingURLQueryItems(){
        viewModel.getCartItems(with: "5")
    }
    
    
}

