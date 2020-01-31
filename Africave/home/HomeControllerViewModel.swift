//
//  HomeControllerViewModel.swift
//  Africave
//
//  Created by Jubril   on 1/28/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation

protocol HomeControllerViewModelDelegate {

  func onPostListSuccess(listOfPosts: [PostResponse])

  func onPostListFailure(errorMessage: String)

}

protocol HomeControllerViewModelProtocol {

  func getAllPosts()

  func onSuccess(listOfPost: [PostResponse])

  func onFailure(errorMessage: String)

  func onPostClicked(postId: Int)

  func onHashTagClicked(hashTag: String)




}

class HomeControllerViewModel: HomeControllerViewModelProtocol {

  var delegate: HomeControllerViewModelDelegate
  var service: APIService

  init(_ service: APIService,_ delegate: HomeControllerViewModelDelegate) {
    self.service = service
    self.delegate = delegate
  }

  func getAllPosts() {
    service.getAllPosts(){ AllPostsResponse in
      if (AllPostsResponse != nil){
        self.onSuccess(listOfPost: AllPostsResponse!.posts)
      } else {
        self.onFailure(errorMessage: "Something went wrong")
      }

    }
  }


  func onPostClicked(postId: Int) {

  }

  func onSuccess(listOfPost: [PostResponse]) {
    delegate.onPostListSuccess(listOfPosts: listOfPost)
  }

  func onHashTagClicked(hashTag: String) {

  }

  func onFailure(errorMessage: String) {
    delegate.onPostListFailure(errorMessage: errorMessage)
  }

}
