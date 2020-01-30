//
//  UserControllerViewModel.swift
//  Africave
//
//  Created by Jubril   on 1/29/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation

protocol UserControllerViewModelDelegate {

  func onUserListSuccess(listOfUsers: [UserResponse])

  func onUserListFailure(errorMessage: String)

}

protocol UserControllerViewModelProtocol {

  func getAllUsers()

  func onSuccess(listOfUsers: [UserResponse])

  func onFailure(errorMessage: String)
}

class UserControllerViewModel: UserControllerViewModelProtocol {

  var delegate: UserControllerViewModelDelegate
  var service: APIService

  init(_ service: APIService,_ delegate: UserControllerViewModelDelegate) {
    self.service = service
    self.delegate = delegate
  }

  func getAllUsers() {
    service.getAllUsers(){ AllUserResponse in
      if (AllUserResponse != nil){
        self.onSuccess(listOfUsers: AllUserResponse!.users)
      } else {
        self.onFailure(errorMessage: "Something went wrong")
      }
    }
  }

  func onSuccess(listOfUsers: [UserResponse]) {
    delegate.onUserListSuccess(listOfUsers: listOfUsers)
  }

  func onFailure(errorMessage: String) {
    delegate.onUserListFailure(errorMessage: errorMessage)
  }

}

