//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 7/1/22.
//

import Foundation
import FluentKit

final public class Token: Model {
    public static let schema = "tokens"
    
    @ID
    public var id: UUID?
    
    @Field(key: "value")
    public var value: String
    
    @Parent(key: "user_id")
    public var user: User
    
    public init() {}
    
    public init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}
