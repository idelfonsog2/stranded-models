//
//  User.swift
//  
//
//  Created by Idelfonso Gutierrez on 5/7/22.
//

import Foundation
import FluentKit

final class User: Model {
   static let schema: String = "users"
   
   @ID(key: .id)
   var id: UUID?
   
   @OptionalChild(for: \Subscription.$user)
   var subscription: Subscription?
   
   @OptionalField(key: "device_token")
   var deviceToken: String?
   
   @Field(key: "name")
   var name: String
   
   @Field(key: "email")
   var email: String
   
   @OptionalField(key: "profile_image")
   var profileImage: Data?
   
   @OptionalField(key: "appleUserIdentifier")
   var appleUserIdentifier: String?
   
   init() {}
   
   init(id: IDValue? = nil,
        deviceToken: String? = nil,
        name: String,
        profileImage: Data? = nil,
        email: String,
        appleUserIdentifier: String?) {
      self.id = id
      self.deviceToken = deviceToken
      self.name = name
      self.email = email
      self.profileImage = profileImage
      self.appleUserIdentifier = appleUserIdentifier
   }
}

extension User {
   // MARK: - Public DTO
   final class Public {
      var name: String?
      var profileImage: Data?
      
      init(name: String?, profileImage: Data?) {
         self.name = name
         self.profileImage = profileImage
      }
   }
   // MARK: - Private DTO
   final class Private {
      var apiToken: String
      var id: UUID
      init(apiToken: String, user: User) throws {
         self.apiToken = apiToken
         self.id = try user.requireID()
      }
   }
}

// MARK: - DTO return
extension User {
   func convertToPublic() -> User.Public {
      return User.Public(name: name, profileImage: profileImage)
   }
}

extension Collection where Element: User {
   func convertToPublic() -> [User.Public] {
      return self.map { $0.convertToPublic() }
   }
}

/// This is domain transfer object
public struct UserRequest: Codable, Equatable {
   public var id: UUID?
   public var name: String?
   public var email: String?
   public var deviceToken: String?
   public var profileImage: Data?
   public var subscriptionId: UUID?
   
   public init(id: UUID? = nil, name: String? = nil, email: String? = nil, deviceToken: String? = nil, profileImage: Data? = nil, subscriptionId: UUID? = nil) {
      self.id = id
      self.name = name
      self.email = email
      self.deviceToken = deviceToken
      self.profileImage = profileImage
      self.subscriptionId = subscriptionId
   }
}

public typealias UserResponse = UserRequest

