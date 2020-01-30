//
//  HomeViewController.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeViewController: UIViewController{
  @IBOutlet weak var postTableView: UITableView!
  var listOfPosts:[PostResponse] = []
  var viewModel: HomeControllerViewModel!

  override func viewDidLoad() {
    let nib = UINib(nibName: "IndividualPost", bundle: nil)
    postTableView.register(nib, forCellReuseIdentifier: "IndividualPost")
    postTableView.dataSource = self
    postTableView.delegate = self
    viewModel = HomeControllerViewModel(APIService.shared,self)
    UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
    
    viewModel.getAllPosts()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .plain, target: self, action: #selector(self.onAddNewPostClicked(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
  }

  @objc
  func onAddNewPostClicked(sender: UIBarButtonItem){

  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return listOfPosts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell  = tableView.dequeueReusableCell(withIdentifier: "IndividualPost") as! IndividualPost
    cell.userNameLabel.text = self.listOfPosts[indexPath.row].user.username
    cell.postImage.kf.setImage(with: URL(string: self.listOfPosts[indexPath.row].image), placeholder: UIImage(named:"placeHolder"))
    cell.hashTagLabels.text = Utils().processedString(word: self.listOfPosts[indexPath.row].hashtags)
    if indexPath.row == listOfPosts.count - 1 {
      UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
         viewModel.getAllPosts()
       }
    return cell
  }


  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let postVC = self.storyboard?.instantiateViewController(identifier: "singlePostController") as! SinglePostController
    postVC.post = listOfPosts[indexPath.row]
    navigationController?.pushViewController(postVC, animated: true)
    
  }
}

extension HomeViewController: HomeControllerViewModelDelegate{

  func onPostListSuccess(listOfPosts: [PostResponse]) {
    UIUtils.shared.dismissProgressBar()
    if self.listOfPosts.isEmpty && !listOfPosts.isEmpty {
      self.listOfPosts = listOfPosts.sorted(){(($0.createdAt)?.compare($1.createdAt))! == .orderedDescending }
      postTableView.reloadData()
    } else {
      self.listOfPosts.append(contentsOf: listOfPosts)
      postTableView.scrollToRow(at: IndexPath(row: (self.listOfPosts.count - listOfPosts.count) - 1, section: 0), at: .top, animated: false)
    }

  }

  func onPostListFailure(errorMessage: String) {
    UIUtils.shared.dismissProgressBar()
    UIUtils.shared.showMessageDialog(message: errorMessage,controller: self)
  }


}

