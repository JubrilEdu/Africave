//
//  SinglePostController.swift
//  Africave
//
//  Created by Jubril   on 1/30/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit
import ActiveLabel

class SinglePostController: UIViewController {
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var postImage: UIImageView!
  @IBOutlet weak var hashTagLabel: ActiveLabel!
  public var post:PostResponse!

  override func viewDidLoad() {
    setUpView(post: post)
  }

  func setUpView(post: PostResponse){
    postImage.kf.setImage(with: URL(string: post.image), placeholder: UIImage(named:"placeHolder"))
    emailLabel.text = post.user.email
    usernameLabel.text = post.user.username
    hashTagLabel.text = Utils().processedString(word: post.hashtags)
    hashTagLabel.hashtagColor = UIColor.blue
    hashTagLabel.handleHashtagTap(){ hashTag in
      let exploreVC = self.storyboard?.instantiateViewController(identifier: "exploreController") as! ExploreViewController
      exploreVC.hashTag = hashTag
      self.navigationController?.pushViewController(exploreVC, animated: true)
    }
  }

}
