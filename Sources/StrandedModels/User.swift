//
//  User.swift
//  
//
//  Created by Idelfonso Gutierrez on 5/7/22.
//

import Foundation
import FluentKit

final public class User: Model {
    public static let schema: String = "users"
    
    @ID(custom: "id", generatedBy: .random)
    public var id: UUID?
    
    @OptionalChild(for: \Subscription.$user)
    public var subscription: Subscription?
    
    @OptionalField(key: "device_token")
    public var deviceToken: String?
    
    @Field(key: "name")
    public var name: String
    
    @Field(key: "email")
    public var email: String
    
    @OptionalField(key: "profile_image")
    public var profileImage: Data?
    
    @OptionalField(key: "appleUserIdentifier")
    public var appleUserIdentifier: String?
    
    public init() {}
    
    public init(id: IDValue? = nil,
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


// MARK: - Public DTO
extension User {
    final public class Public: Codable {
        public var name: String?
        public var profileImage: Data?
        
        public init(name: String?, profileImage: Data?) {
            self.name = name
            self.profileImage = profileImage
        }
    }
    // MARK: - Private DTO
    final public class Private: Codable {
        public var apiToken: String
        public var id: UUID
        
        public init(apiToken: String, userID: UUID) {
            self.apiToken = apiToken
            self.id = userID
        }
    }
}

// MARK: - DTO return
extension User {
    public func convertToPublic() -> User.Public {
        return User.Public(name: name, profileImage: profileImage)
    }
}

extension Collection where Element: User {
    public func convertToPublic() -> [User.Public] {
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

