//
//  SignUpViewModel.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation

protocol SignUpViewModelDelegate {

  func onSignUpSuccess()

  func onSignUpFailure(errorMessage: String)

}

protocol SignUpViewModelProtocol {

  func SignUpUser(username: String, password: String, email: String)

  func onSignUpSuccess()

  func onSignUpFailure(errorMessage: String)

}

class SignUpViewModel: SignUpViewModelProtocol {

  var delegate: SignUpViewModelDelegate
  var service: APIService

  init(_ service: APIService,_ delegate: SignUpViewModelDelegate) {
    self.service = service
    self.delegate = delegate
  }

  func onSignUpSuccess() {
    delegate.onSignUpSuccess()
  }

  func onSignUpFailure(errorMessage: String) {
    delegate.onSignUpFailure(errorMessage: errorMessage)
  }


  func SignUpUser(username: String, password: String, email: String) {
    service.signUp(username: username, email: email, password: password){ RegisterResponse in
      if RegisterResponse != nil {
        self.onSignUpSuccess()
      } else {
        self.onSignUpFailure(errorMessage: "Something went wrong")
      }
    }
  }
}
