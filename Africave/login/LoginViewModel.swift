//
//  LoginViewModel.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {

  func onLoginSuccess()

  func onLoginFailure(errorMessage: String)

}

protocol LoginViewModelProtocol {

  func loginUser(password: String, email: String)

  func onLoginSuccess()

  func onLoginFailure(errorMessage: String)

}

class LoginViewModel: LoginViewModelProtocol {

  var delegate: LoginViewModelDelegate
  var service: APIService

  init(_ service: APIService,_ delegate: LoginViewModelDelegate) {
    self.service = service
    self.delegate = delegate
  }

  func onLoginSuccess() {
    delegate.onLoginSuccess()
  }

  func onLoginFailure(errorMessage: String) {
    delegate.onLoginFailure(errorMessage: errorMessage)
  }


  func loginUser(password: String, email: String) {
    service.login(email: email, password: password) { RegisterResponse in
      if RegisterResponse != nil {
            StorageUtil.shared.saveString(string: RegisterResponse?.token,key:"token")
             self.onLoginSuccess()
           } else {
             self.onLoginFailure(errorMessage: "Something went wrong")
           }
    }
  }
}
