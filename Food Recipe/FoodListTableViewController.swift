//
//  FoodListTableViewController.swift
//  Food Recipe
//
//  Created by Tiange Wang on 9/16/18.
//  Copyright © 2018 Tiange Wang. All rights reserved.
//

import UIKit
import CoreData

class FoodListTableViewController: UITableViewController {

    var foodList: [Food] = []
    var clickedOnFoodName: String?
    var clickedOnFoodData: Data?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    let foodRequest:NSFetchRequest<Food> = Food.fetchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllFood()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food")!
        cell.textLabel!.text = foodList[indexPath.row].name!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickedOnFoodName = foodList[indexPath.row].name
        clickedOnFoodData = foodList[indexPath.row].image
        performSegue(withIdentifier: "RecipeSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(foodList[indexPath.row])
        saveContext()
        fetchAllFood()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFoodSegue" {
            let destination = segue.destination as! AddFoodViewController
            destination.delegate = self
        } else if segue.identifier == "RecipeSegue" {
            let destination = segue.destination as! RecipeViewController
            destination.foodName = clickedOnFoodName
            destination.imgData = clickedOnFoodData
        }
    }
    
    func fetchAllFood() {
        do {
            foodList = try context.fetch(foodRequest)
        } catch {
            print(error)
        }
    }

}
extension FoodListTableViewController: AddFoodDelegate {
    
    func addFood(name: String, recipes: [String], image: Data) {
        print("Through the delegate")
        let newFood = Food(context: context)
        newFood.name = name
        newFood.image = image
        saveContext()
        fetchAllFood()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
}
