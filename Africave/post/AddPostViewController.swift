//
//  AddPostViewController.swift
//  Africave
//
//  Created by Jubril   on 1/30/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit

class AddPostViewController:UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleTextView: UITextField!
  @IBOutlet weak var hashTagTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  var imagePicker = UIImagePickerController()

  override func viewDidLoad() {
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    imageView.isUserInteractionEnabled = true

  }

  @objc
  func onTap(_ gestureRecognizer: UITapGestureRecognizer){
    if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
  }





  @IBAction func onClickUpload(_ sender: Any) {
  }
}


extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
  }

}
