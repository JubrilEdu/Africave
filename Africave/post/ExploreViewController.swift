//
//  ExploreViewController.swift
//  Africave
//
//  Created by Jubril   on 1/31/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit

class ExploreViewController: UIViewController {
  @IBOutlet weak var postTableView: UITableView!
  public var hashTag:String!
  var listOfPosts:[PostResponse] = []
  var viewModel: ExploreControllerViewModel!
  var reload: Bool = true

  override func viewDidLoad() {
    let nib = UINib(nibName: "IndividualPost", bundle: nil)
    postTableView.register(nib, forCellReuseIdentifier: "IndividualPost")
    postTableView.dataSource = self
    postTableView.delegate = self
    viewModel = ExploreControllerViewModel(APIService.shared,self)
    UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
    viewModel.onHashTagClicked(hashTag: hashTag!)
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      StorageUtil.shared.saveInt(value:0, key: "hashtag_post_offset")
      listOfPosts.removeAll()
      reload = true
  }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return listOfPosts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell  = tableView.dequeueReusableCell(withIdentifier: "IndividualPost") as! IndividualPost
    cell.userNameLabel.text = self.listOfPosts[indexPath.row].user.username
    cell.postImage.kf.setImage(with: URL(string: self.listOfPosts[indexPath.row].image), placeholder: UIImage(named:"placeHolder"))
    cell.hashTagLabels.text = Utils().processedString(word: self.listOfPosts[indexPath.row].hashtags)
    if indexPath.row == (listOfPosts.count - 1) && reload {
      UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
         viewModel.onHashTagClicked(hashTag: hashTag!)
       }
    return cell
  }


  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
}

extension ExploreViewController: ExploreControllerViewModelDelegate {
  func onPostListSuccess(listOfPosts: [PostResponse]) {
    UIUtils.shared.dismissProgressBar()
    if listOfPosts.isEmpty {
      reload = false
    } else {
      reload = true
    }
    if self.listOfPosts.isEmpty && !listOfPosts.isEmpty {
      self.listOfPosts = listOfPosts.sorted(){(($0.createdAt)?.compare($1.createdAt))! == .orderedDescending }
      postTableView.reloadData()
    } else {
      self.listOfPosts.append(contentsOf: listOfPosts.sorted(){(($0.createdAt)?.compare($1.createdAt))! == .orderedDescending })
      postTableView.reloadData()
    }
  }

  func onPostListFailure(errorMessage: String) {
    UIUtils.shared.dismissProgressBar()
    UIUtils.shared.showMessageDialog(message: errorMessage,controller: self)
  }


}
