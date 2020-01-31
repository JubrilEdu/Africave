//
//  UsersViewController.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit

class UsersViewController: UIViewController {

  @IBOutlet weak var userTableView: UITableView!
  var listOfUsers:[UserResponse] = []
  var viewModel: UserControllerViewModel!
  var reload: Bool = true

  override func viewDidLoad() {
    userTableView.dataSource = self
    viewModel = UserControllerViewModel(APIService.shared,self)
    UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
    viewModel.getAllUsers()
  }

}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listOfUsers.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = listOfUsers[indexPath.row].username
    cell.detailTextLabel?.text = listOfUsers[indexPath.row].email
    if indexPath.row == listOfUsers.count - 1 && reload {
      UIUtils.shared.showProgressBar(message: "Loading", view: self.view)
      viewModel.getAllUsers()
    }
    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

extension UsersViewController: UserControllerViewModelDelegate {
  func onUserListSuccess(listOfUsers: [UserResponse]) {
    UIUtils.shared.dismissProgressBar()
    if listOfUsers.isEmpty {
         reload = false
       } else {
         reload = true
       }
    if self.listOfUsers.isEmpty && !listOfUsers.isEmpty {
      self.listOfUsers = listOfUsers
      userTableView.reloadData()
    } else {
      self.listOfUsers.append(contentsOf: listOfUsers)
      userTableView.reloadData()
      userTableView.scrollToRow(at: IndexPath(row: (self.listOfUsers.count - listOfUsers.count) - 1, section: 0), at: .top, animated: false)
    }

  }

  func onUserListFailure(errorMessage: String) {
    UIUtils.shared.dismissProgressBar()
    UIUtils.shared.showMessageDialog(message: errorMessage,controller: self)
  }


}


