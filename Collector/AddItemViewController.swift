//
//  AddItemViewController.swift
//  Collector
//
//  Created by Michael on 2018-01-06.
//  Copyright © 2018 Differential Consulting. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // picker is looking for a delegate to handle returned data
        //  need to add interface for UIImagePickerControllerDelegate
        //  and UINavigationControllerDelegate
        imagePicker.delegate = self
    }
    
    
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        // could have a callback, we don't need it though
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        // could have a callback, we don't need it though
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = choosenImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.title = titleTextField.text
            
            if let image = itemImageView.image {
                if let imageData = UIImagePNGRepresentation(image) {
                    item.image = imageData
                }
            }
            
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    
}












