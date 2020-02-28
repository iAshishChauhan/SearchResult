//
//  ProductDataModel.swift
//  SearchAPI
//
//  Created by Ashish Singh Chauhan on 27/02/20.
//  Copyright © 2020 Ashish Singh Chauhan. All rights reserved.
//

import UIKit

class ProductDataModel: Codable {
    var data: Data?
}

class Data: Codable {
    var products: [Product]?
}

class Product: Codable {
    var name: String?
    var images: [String]?
}
