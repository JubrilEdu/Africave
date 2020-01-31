//
//  Utils.swift
//  Africave
//
//  Created by Jubril   on 1/30/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation

struct Utils {
  func processedString(word: String) -> String {
     let old = word.split(separator: ",")
     var result:String = ""
     for new in old {
       result.append("#\(new) ")
     }
     return result
   }

}
