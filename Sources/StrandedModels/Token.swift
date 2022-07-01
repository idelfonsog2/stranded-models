//
//  Token.swift
//
//
//  Created by Idelfonso Gutierrez on 9/4/21.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor
import Crypto

final class Token: Model, Content {
    static let schema = "tokens"
    
    @ID
    var id: UUID?
    
    @Field(key: "value")
    var value: String
    
    @Parent(key: "user_id")
    var user: User
    
    init() {}
    
    init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}

extension Token {
    static func generate(for user: User) throws -> Token {
        let random = [UInt8].random(count: 16).base64
        return try Token(value: random, userID: user.requireID())
    }
}

// NOTE: use the token with HTTP Bearer Authentication
// 1bearer authentication` authenticates requests
extension Token: ModelTokenAuthenticatable {
    static let userKey = \Token.$user
    static let valueKey = \Token.$value
    
    var isValid: Bool {
        // future: we might want to add and expiry date before returning true
        true
    }
}
