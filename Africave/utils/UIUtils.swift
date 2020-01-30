//
//  UIUtils.swift
//  Africave
//
//  Created by Jubril   on 1/30/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

class UIUtils {
  static let shared = UIUtils()
  let hud = JGProgressHUD(style: .dark)

  private init(){

  }

  func showProgressBar(message: String?,view: UIView){
    if !hud.isVisible {
      hud.textLabel.text = message
      hud.show(in: view)
    }
  }

  func dismissProgressBar(){
    if hud.isVisible {
      hud.dismiss()
    }
  }

  func showMessageDialog(message: String, controller: UIViewController){
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    controller.present(alert, animated: true, completion: nil)
  }
}
