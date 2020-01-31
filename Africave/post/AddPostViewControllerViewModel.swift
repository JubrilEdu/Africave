//
//  AddPostViewControllerViewModel.swift
//  Africave
//
//  Created by Jubril   on 1/31/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit

protocol AddPostControllerViewModelDelegate {

  func onPostListSuccess()

  func onPostListFailure(errorMessage: String)

}

protocol AddPostControllerViewModelProtocol {

  func uploadPost(parameter: [String:String], image: UIImage)

  func onSuccess()

  func onFailure(errorMessage: String)

}

class AddPostControllerViewModel: AddPostControllerViewModelProtocol {
  var delegate: AddPostControllerViewModelDelegate
  var service: APIService

  init(_ service: APIService,_ delegate: AddPostControllerViewModelDelegate) {
    self.service = service
    self.delegate = delegate
  }

  func uploadPost(parameter: [String:String], image: UIImage) {
    service.sendNewPost(parameters: parameter, image: image) { response in
      if (response != nil){
        self.onSuccess()
      } else {
        self.onFailure(errorMessage: "Something went wrong")
      }
          }
    }

  func onSuccess() {
    delegate.onPostListSuccess()
  }


  func onFailure(errorMessage: String) {
    delegate.onPostListFailure(errorMessage: errorMessage)
  }

}
