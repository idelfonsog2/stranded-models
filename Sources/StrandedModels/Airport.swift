//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 7/1/22.
//

import Foundation
import FluentKit

final public class Airport: Model {
    public static let schema: String = "airport"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Children(for: \.$airport)
    public var subscriptions: [Subscription]
    
    @OptionalField(key: "iata_code")
    public var iataCode: String?
    
    @Field(key: "name")
    public var name: String
    
    public init() { }
    
    public init(id: IDValue? = nil, iataCode: String, name: String) {
        self.id = id
        self.iataCode = iataCode
        self.name = name
    }
}
