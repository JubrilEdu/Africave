//
//  APIConstants.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation

struct APIConstants {

  func getBaseUrl() -> String {
    return "https://ios-test-january-2020.africave.co/api/v1";
  }

}


struct APIEndpoints {
  func getRegisterUrl() -> URL {
    return URL(string: "\(APIConstants().getBaseUrl())/register")!
  }

  func getLoginUrl() -> URL {
     return URL(string: "\(APIConstants().getBaseUrl())/login")!
  }

  func getUserUrl(userId: Int) -> URL {
     return URL(string: "\(APIConstants().getBaseUrl())/users/\(userId)")!
   }

  func getPostUrl(limit: Int,offset: Int) -> URL {
     return URL(string: "\(APIConstants().getBaseUrl())/posts/?limit=\(limit)&offset=\(offset)")!
   }

  func getSinglePostUrl(postId: Int) -> URL {
    return URL(string: "\(APIConstants().getBaseUrl())/posts/\(postId)")!
  }

  func getExploreUrl(hashtag: String) -> URL {
     return URL(string: "\(APIConstants().getBaseUrl())/explore/\(hashtag)")!
   }

  func getAllUsersUrl(limit: Int,offset: Int) -> URL {
    return URL(string: "\(APIConstants().getBaseUrl())/users?limit=\(limit)&offset=\(offset)")!
  }
}
