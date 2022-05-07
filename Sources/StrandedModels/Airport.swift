//
//  Airport.swift
//  
//
//  Created by Idelfonso Gutierrez on 5/7/22.
//

import Foundation
import FluentPostgresDriver

final class Airport: Model {
   static let schema: String = "airport"
   
   @ID(key: .id)
   var id: UUID?
   
   @Children(for: \.$airport)
   var subscriptions: [Subscription]
   
   @OptionalField(key: "iata_code")
   var iataCode: String?
   
   @Field(key: "name")
   var name: String
   
   init() { }
   
   init(id: IDValue? = nil, iataCode: String, name: String) {
      self.id = id
      self.iataCode = iataCode
      self.name = name
   }
}

