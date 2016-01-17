//
//  Restaurant.swift
//  FoodPin
//
//  Created by Simon Ng on 19/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import Foundation

class Book {
    var name:String = ""
    var course:String = ""
    var ISBNNumber:String = ""
    var image:String = ""
    var condition:String = ""
    var price:Int = 0
    var seller:String = ""
    init(name:String, course:String, ISBNNumber:String, image:String, condition:String, price:Int, seller: String) {
        self.name = name
        self.course = course
        self.ISBNNumber = ISBNNumber
        self.image = image
        self.condition = condition
        self.price = price
        self.seller = seller
    }
}