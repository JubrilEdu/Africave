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
  var viewModel: AddPostControllerViewModel!

  override func viewDidLoad() {
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    imageView.isUserInteractionEnabled = true
    viewModel = AddPostControllerViewModel(APIService.shared, self)

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
    let parameter = ["title": titleTextView.text,"description": descriptionTextField.text,"hashtags":hashTagTextField.text?.replacingOccurrences(of: " ", with: ",")]
    UIUtils.shared.showProgressBar(message: "Uploading", view: self.view)
    viewModel.uploadPost(parameter: parameter as! [String : String], image: imageView.image!)
  }
}


extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        imageView.image = image
    }
  }
}


extension AddPostViewController: AddPostControllerViewModelDelegate {
  func onPostListSuccess() {
    UIUtils.shared.dismissProgressBar()
    navigationController?.popViewController(animated: true)

  }

  func onPostListFailure(errorMessage: String) {
    UIUtils.shared.dismissProgressBar()
    UIUtils.shared.showMessageDialog(message: errorMessage, controller: self)
  }


}
