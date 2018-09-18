//
//  AddFoodViewController.swift
//  Food Recipe
//
//  Created by Tiange Wang on 9/16/18.
//  Copyright © 2018 Tiange Wang. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let imagePicker = UIImagePickerController()
    var recipeList: [String] = [""]
    var delegate: AddFoodDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBAction func addNewRecipe(_ sender: UIButton) {
        recipeList.append("")
        tableView.reloadData()
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveNewFood(_ sender: UIBarButtonItem) {
        if let data = imageView.image?.pngData() {
            delegate?.addFood(name: nameLabel.text!, recipes: [], image: data)
        } else {
            let defaultImgData = UIImage(named: "default")!.pngData()!
            delegate?.addFood(name: nameLabel.text!, recipes: [], image: defaultImgData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "default")!
        tableView.dataSource = self
        tableView.delegate = self
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
extension AddFoodViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeCell") as! AddRecipeCell
        if indexPath.row > 0 {
            cell.recipeLabel.isHidden = true
        } else {
            cell.recipeLabel.isHidden = false
        }
        cell.recipeTextField.text = recipeList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
}
