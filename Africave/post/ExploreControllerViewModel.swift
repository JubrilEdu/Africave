//
//  ExploreControllerViewModel.swift
//  Africave
//
//  Created by Jubril   on 1/31/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation


protocol ExploreControllerViewModelDelegate {

  func onPostListSuccess(listOfPosts: [PostResponse])

  func onPostListFailure(errorMessage: String)

}

protocol ExploreControllerViewModelProtocol {


  func onSuccess(listOfPost: [PostResponse])

  func onFailure(errorMessage: String)

  func onHashTagClicked(hashTag: String)




}

class ExploreControllerViewModel: ExploreControllerViewModelProtocol {

  var delegate: ExploreControllerViewModelDelegate
  var service: APIService

  init(_ service: APIService,_ delegate: ExploreControllerViewModelDelegate) {
    self.service = service
    self.delegate = delegate
  }

  func onSuccess(listOfPost: [PostResponse]) {
    delegate.onPostListSuccess(listOfPosts: listOfPost)
  }

  func onHashTagClicked(hashTag: String) {
    service.getPostsByHashTag(hashTag: hashTag){ AllPostsResponse in
      if (AllPostsResponse != nil){
             self.onSuccess(listOfPost: AllPostsResponse!.posts)
           } else {
             self.onFailure(errorMessage: "Something went wrong")
           }
    }
  }

  func onFailure(errorMessage: String) {
    delegate.onPostListFailure(errorMessage: errorMessage)
  }

}
