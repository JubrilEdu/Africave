//
//  LogInViewController.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField
import UIKit
import JGProgressHUD

class LogInViewController: UIViewController {

  @IBOutlet weak var passwordTextfield: SkyFloatingLabelTextField!
  @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
  var viewModel: LoginViewModel!

  override func viewDidLoad() {
    viewModel = LoginViewModel(APIService.shared, self)
    emailTextField.text = "bee@example.com"
    passwordTextfield.text = "qwerty123"
  }



  @IBAction func onLoginClicked(_ sender: Any) {
    if !(passwordTextfield.text?.isEmpty ?? true) && !(emailTextField.text?.isEmpty ?? true){
         UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
         viewModel.loginUser(password: passwordTextfield.text!, email: emailTextField.text!)
       } else {
         showErrorMessage(message: "Something went wrong, Try again")
    }
  }

  func showErrorMessage(message: String){
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }


}

extension LogInViewController: LoginViewModelDelegate {
  func onLoginSuccess() {
    UIUtils.shared.dismissProgressBar()
    let homeVC =  self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
    self.present(homeVC, animated: true, completion: nil)
  }

  func onLoginFailure(errorMessage: String) {
    UIUtils.shared.dismissProgressBar()
    showErrorMessage(message: "Something went wrong, Try again")
  }



}
