//
//  NewFoodDelegate.swift
//  Food Recipe
//
//  Created by Tiange Wang on 9/17/18.
//  Copyright © 2018 Tiange Wang. All rights reserved.
//

import Foundation

protocol AddFoodDelegate {
    func addFood(name: String, recipes: [String], image: Data)
}
