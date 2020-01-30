//
//  APIResponse.swift
//  Africave
//
//  Created by Jubril   on 1/28/20.
//  Copyright © 2020 Jubril. All rights reserved.
//
import Foundation
import EVReflection



@objc(RegisterResponse)
public class RegisterResponse: EVNetworkingObject {
    public var token: String!
    public var user: UserResponse! = UserResponse()
}

@objc(UserResponse)
public class UserResponse: EVNetworkingObject{
  public var id: Int!
  public var username: String!
  public var email: String!
  public var updatedAt: String!
  public var createdAt: String!
}

@objc(Post)
public class PostResponse: EVNetworkingObject{
   public var id: Int!
   public var updatedAt: String!
   public var createdAt: String!
   public var title: String!
   public var hashtags: String!
   public var image: String!
   public var user: UserResponse! = UserResponse()
}

@objc(User)
public class User: EVNetworkingObject{
   public var users: UserResponse! = UserResponse()
}

@objc(AllPostsResponse)
public class AllPostsResponse: EVNetworkingObject{
  public var posts:[PostResponse]!
}

@objc(AllUserResponse)
public class AllUserResponse: EVNetworkingObject{
  public var users:[UserResponse]!
}


