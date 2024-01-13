//
//  ProductData.swift
//  StructApiResponce
//
//  Created by Mac on 16/10/23.
//

import Foundation
import SwiftUI
struct APIResponse{
    var products : [Product]
    var total : Int
    var skipc : Int
    var limit : Int
}
struct Product{
    var id : Int
    var title : String
    var description : String
    var price : Int
    var discountPercentage : Float
    var rating : Double
    var stock : Double
    var brand : String
    var category : String
    var thumbnail : String
    var images : [String]
}
