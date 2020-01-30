//
//  SinglePostController.swift
//  Africave
//
//  Created by Jubril   on 1/30/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit

class SinglePostController: UIViewController {
  @IBOutlet weak var hashtagLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var postImage: UIImageView!
  public var post:PostResponse!

  override func viewDidLoad() {
    setUpView(post: post)
  }

  func setUpView(post: PostResponse){
    postImage.kf.setImage(with: URL(string: post.image), placeholder: UIImage(named:"placeHolder"))
    emailLabel.text = post.user.email
    usernameLabel.text = post.user.username
    hashtagLabel.text = Utils().processedString(word: post.hashtags)
  }

}
