//
//  Subscription.swift
//  
//
//  Created by Idelfonso Gutierrez on 5/7/22.
//

import Foundation

/// This is domain transfer object
public struct SubscriptionRequest: Codable, Equatable {
   public var airportId: UUID
   public var departureDate: Date
   public var gate: String?
   public var terminal: String?
   public var profileImage: Data?
   
   public init(airportId: UUID, departureDate: Date, gate: String? = nil, terminal: String? = nil, profileImage: Data? = nil) {
      self.airportId = airportId
      self.departureDate = departureDate
      self.gate = gate
      self.terminal = terminal
      self.profileImage = profileImage
   }
}

/// This is domain transfer object
public struct SubscriptionResponse: Codable, Equatable {
   public var me: ItemSubscription
   public var others: [ItemSubscription]
   
   public init(me: SubscriptionResponse.ItemSubscription, others: [SubscriptionResponse.ItemSubscription]) {
      self.me = me
      self.others = others
   }
   
   public struct ItemSubscription: Codable, Equatable {
      public var id: UUID?
      public var name: String?
      public var departureDate: Date
      public var gate: String?
      public var terminal: String?
      public var profileImage: Data?
      
      public init(id: UUID?, name: String? = nil, departureDate: Date, gate: String? = nil, terminal: String? = nil, profileImage: Data? = nil) {
         self.id = id
         self.name = name
         self.departureDate = departureDate
         self.gate = gate
         self.terminal = terminal
         self.profileImage = profileImage
      }
      
      enum CodingKeys: String, CodingKey {
         case id
         case name
         case departureDate
         case gate
         case terminal
         case profileImage
      }
      
      public init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         id = try values.decode(UUID?.self, forKey: .id)
         name = try values.decodeIfPresent(String.self, forKey: .name)
         
         let dateValue = try values.decode(String.self, forKey: .departureDate)
         departureDate = ISO8601DateFormatter().date(from: dateValue) ?? Date().addingTimeInterval(1000)
         
         gate = try values.decodeIfPresent(String.self, forKey: .gate)
         terminal = try values.decodeIfPresent(String.self, forKey: .terminal)
         profileImage = try values.decodeIfPresent(Data.self, forKey: .profileImage)
      }
   }
}

extension SubscriptionResponse.ItemSubscription: Hashable, Identifiable { }
