//
//  RecipeViewController.swift
//  Food Recipe
//
//  Created by Tiange Wang on 9/16/18.
//  Copyright © 2018 Tiange Wang. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationItem!
    var foodName: String?
    var imgData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = foodName
        imageView.image = UIImage(data: imgData!)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe")!
        cell.textLabel?.text = "Recipe"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
