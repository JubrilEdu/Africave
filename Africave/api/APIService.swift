//
//  APIService.swift
//  Africave
//
//  Created by Jubril   on 1/27/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Alamofire

class APIService {
  static let shared = APIService()
  let postsLimit = 2
  let userLimit = 10
  let SuccessCode = 200

//  var headers: HTTPHeaders = [
//     "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNTgwMzg0NTIwLCJleHAiOjE1ODAzOTUzMjB9.eYyjteeSpP2D29SWxR7o6-qvi8YcWz60jiNDhnu2t90",
//       "Content-Type": "application/x-www-form-urlencoded"]

  func signUp(username: String, email: String, password: String,
              completion: @escaping (_ register: RegisterResponse?) -> Void ) {
    let parameters = ["username":username, "email":email,"password":password]
    Alamofire.request(APIEndpoints().getRegisterUrl(), method: .post, parameters: parameters,
                      encoding: URLEncoding.default).responseObject{
      (response: DataResponse<RegisterResponse>) in
                        if (response.response?.statusCode == self.SuccessCode){
                          completion(response.result.value)
                        } else {
                          completion(nil)
                        }
    }
  }

  func login(email: String, password: String,
               completion: @escaping (_ register: RegisterResponse?) -> Void ) {
     let parameters = ["email":email,"password":password]
     Alamofire.request(APIEndpoints().getLoginUrl(), method: .post, parameters: parameters,
                       encoding: URLEncoding.default).responseObject{
       (response: DataResponse<RegisterResponse>) in
                         if (response.response?.statusCode == self.SuccessCode){
                           completion(response.result.value)
                         } else {
                           completion(nil)
                         }
     }
   }

  func getToken() -> String {
    if StorageUtil.shared.contains(key: "token") {
      return StorageUtil.shared.getString(key: "token")!
    } else {
      return ""
    }
  }

  func getAllPosts(completion: @escaping (_ register: AllPostsResponse?) -> Void ) {
     let offset = StorageUtil.shared.getInt(key: "post_offset")
     let headers: HTTPHeaders = [
      "Authorization": "Bearer \(self.getToken())",
        "Content-Type": "application/x-www-form-urlencoded"]
    Alamofire.request(APIEndpoints().getPostUrl(limit: self.postsLimit, offset: offset),method: .get,encoding: URLEncoding.default, headers: headers
                       ).responseObject{
       (response: DataResponse<AllPostsResponse>) in
                        print(response.request?.allHTTPHeaderFields)
                        print(response.response)
                        if (response.response?.statusCode == self.SuccessCode){
                          StorageUtil.shared.saveInt(value: offset + self.postsLimit, key: "post_offset")
                          completion(response.result.value)
                        } else {
                          completion(nil)
                        }
     }
   }

  func getPost(postId: Int,completion: @escaping (_ register: AllPostsResponse?) -> Void ) {
     Alamofire.request(APIEndpoints().getSinglePostUrl(postId: postId), method: .post,
                       encoding: URLEncoding.default).responseObject{
       (response: DataResponse<AllPostsResponse>) in
                         switch response.result {
                         case .success(_):
                           completion(response.result.value)
                         case .failure(_):
                           completion(nil)
                         }
     }
   }

  func getAllUsers(completion: @escaping (_ register: AllUserResponse?) -> Void){
    let offset = StorageUtil.shared.getInt(key: "user_offset")
    let headers: HTTPHeaders = [
    "Authorization": "Bearer \(self.getToken())",
      "Content-Type": "application/x-www-form-urlencoded"]
    Alamofire.request(APIEndpoints().getAllUsersUrl(limit: self.userLimit,offset: offset),method: .get,
                      encoding: JSONEncoding.default, headers: headers).responseObject{ (response: DataResponse<AllUserResponse>) in
      if response.response?.statusCode == self.SuccessCode {
        StorageUtil.shared.saveInt(value: offset + self.userLimit, key: "user_offset")
        completion(response.result.value)
      } else {
        completion(nil)
      }
    }
  }



}
