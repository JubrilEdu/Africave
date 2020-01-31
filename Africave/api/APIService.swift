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
  let postsLimit = 3
  let userLimit = 12
  let SuccessCode = 200


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


  func sendNewPost(parameters: [String:String], image: UIImage,completion: @escaping (_ register: PostResponse?) -> Void){
    let headers: HTTPHeaders = [
     "Authorization": "Bearer \(self.getToken())",
       "Content-Type": "application/x-www-form-urlencoded"]
    Alamofire.upload(multipartFormData: { multipartFormData in

      if let imageData =  image.jpegData(compressionQuality:0.5) {
        multipartFormData.append(imageData, withName: "image", fileName: "file.png", mimeType: "image/png")
      }

    for (key, value) in parameters {
        multipartFormData.append((value.data(using: .utf8))!, withName: key)
      }}, to: APIEndpoints().createPost(), method: .post, headers: headers,
          encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
              upload.responseObject(completionHandler: {(response: DataResponse<PostResponse>) in
                completion(response.result.value)
              })
            case .failure( _):
              completion(nil)
            }
      })
  }

  func getPostsByHashTag(hashTag: String, completion: @escaping (_ register: AllPostsResponse?) -> Void ) {
     let offset = StorageUtil.shared.getInt(key: "hashtag_post_offset")
     let headers: HTTPHeaders = [
      "Authorization": "Bearer \(self.getToken())",
        "Content-Type": "application/x-www-form-urlencoded"]
    Alamofire.request(APIEndpoints().getPostByHashtag(hashTag: hashTag,limit: self.postsLimit, offset: offset),method: .get,encoding: URLEncoding.default, headers: headers
                       ).responseObject{
       (response: DataResponse<AllPostsResponse>) in
                        if (response.response?.statusCode == self.SuccessCode){
                          StorageUtil.shared.saveInt(value: offset + self.postsLimit, key: "hashtag_post_offset")
                          completion(response.result.value)
                        } else {
                          completion(nil)
                        }
     }
   }



}
