//
//  SignUpViewController.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import JGProgressHUD

class SignUpViewController: UIViewController {

  @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var userNameTextField: SkyFloatingLabelTextField!
  var viewModel: SignUpViewModel!


  override func viewDidLoad() {
    viewModel = SignUpViewModel(APIService.shared,self)
  }

  @IBAction func onClickSignUpButton(_ sender: Any) {
    if !(passwordTextField.text?.isEmpty ?? true) && !(emailTextField.text?.isEmpty ?? true)
      && !(userNameTextField.text?.isEmpty ?? true) {
      UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
      viewModel.SignUpUser(username: userNameTextField.text!, password: passwordTextField.text!,
                           email: emailTextField.text!)

    } else {
      UIUtils.shared.showMessageDialog(message: "Something went wrong, Try again", controller: self)
    }
  }
}


extension SignUpViewController: SignUpViewModelDelegate {

  func onSignUpSuccess() {
    UIUtils.shared.dismissProgressBar()
    StorageUtil.shared.saveBoolean(value: true, key: "old_user")
    let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LogInViewController
    self.present(loginVC, animated: true, completion: nil)

  }

  func onSignUpFailure(errorMessage: String) {
    UIUtils.shared.dismissProgressBar()
    UIUtils.shared.showMessageDialog(message: "Something went wrong, Try again", controller: self)
  }


}
