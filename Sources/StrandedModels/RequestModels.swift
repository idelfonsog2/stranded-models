//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 9/12/21.
//

import Foundation

public enum APIError: Error {
   case signInWithApple
   case malformedURL
}

/// This is domain transfer object
public struct UserRequest: Codable {
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

public class User: Codable { }

extension User {
   public final class Public: Codable {
      public var name: String?
      public var profileImage: Data?
      
      public init(name: String?, profileImage: Data?) {
         self.name = name
         self.profileImage = profileImage
      }
   }
   
   public final class Private: Codable {
      public var apiToken: String
      public var id: UUID
      public init(apiToken: String, userID: UUID) {
         self.apiToken = apiToken
         self.id = userID
      }
   }
}

/// This is domain transfer object
public struct SubscriptionRequest: Codable {
   public init(airportId: UUID, userId: UUID, departureDate: Date, gate: String? = nil, terminal: String? = nil) {
      self.airportId = airportId
      self.userId = userId
      self.departureDate = departureDate
      self.gate = gate
      self.terminal = terminal
   }
   
   public var airportId: UUID
   public var userId: UUID
   public var departureDate: Date
   public var gate: String?
   public var terminal: String?
}

/// This is domain transfer object
public struct SubscriptionResponse: Codable {
   public init(me: SubscriptionResponse.ItemSubscription, others: [SubscriptionResponse.ItemSubscription]) {
      self.me = me
      self.others = others
   }
   
   public var me: ItemSubscription
   public var others: [ItemSubscription]
   
   public struct ItemSubscription: Codable {
      public init(id: UUID?, name: String? = nil, departureDate: Date, gate: String? = nil, terminal: String? = nil, profileImage: Data? = nil) {
         self.id = id
         self.name = name
         self.departureDate = departureDate
         self.gate = gate
         self.terminal = terminal
         self.profileImage = profileImage
      }
      
      public var id: UUID?
      public var name: String?
      public var departureDate: Date
      public var gate: String?
      public var terminal: String?
      public var profileImage: Data?
   }
}

extension SubscriptionResponse.ItemSubscription: Hashable, Identifiable { }

/// This is domain transfer object between third-party -> strandedAPI -> ios client
public struct FlightInformation: Codable {
   public static let sampleURL = Bundle.module.url(forResource: "flight_information", withExtension: "json")!
   
   public init(departure: FlightInformation.FlightInfo, arrival: FlightInformation.FlightInfo, lastUpdatedUtc: String, number: String, status: String, airline: FlightInformation.Airline) {
      self.departure = departure
      self.arrival = arrival
      self.lastUpdatedUtc = lastUpdatedUtc
      self.number = number
      self.status = status
      self.airline = airline
   }
   
   public var departure: FlightInfo
   public var arrival: FlightInfo
   public var lastUpdatedUtc: String
   public var number: String
   public var status: String
   public var airline: Airline
   
   public struct Airline: Codable {
      public init(name: String) {
         self.name = name
      }
      
      public var name: String
   }
   
   public struct FlightInfo: Codable {
      public init(airport: FlightInformation.Airport, scheduledTimeUtc: Date, actualTimeUtc: Date?, scheduledTimeLocal: Date?, actualTimeLocal: Date?, terminal: String? = nil, gate: String? = nil) {
         self.airport = airport
         self.scheduledTimeUtc = scheduledTimeUtc
         self.actualTimeUtc = actualTimeUtc
         self.terminal = terminal
         self.gate = gate
         self.scheduledTimeLocal = scheduledTimeLocal
         self.actualTimeLocal = actualTimeLocal
      }
      
      public var airport: Airport
      public var scheduledTimeUtc: Date
      public var actualTimeUtc: Date?
      public var terminal: String?
      public var gate: String?
      public var scheduledTimeLocal: Date? // NOTE: its better cause they are searching the flight on their time zone
      public var actualTimeLocal: Date?
   }
   
   
   public struct Airport: Codable {
      public init(id: UUID? = nil, icao: String, iata: String, name: String, shortName: String, municipalityName: String) {
         self.id = id
         self.icao = icao
         self.iata = iata
         self.name = name
         self.shortName = shortName
         self.municipalityName = municipalityName
      }
      
      public var id: UUID? // TODO: This is the ID from the STRANDED API MODEL
      public var icao: String
      public var iata: String
      public var name: String
      public var shortName: String
      public var municipalityName: String
   }
   
   public struct Location: Codable {
      public init(lat: Double, lon: Double) {
         self.lat = lat
         self.lon = lon
      }
      
      public var lat: Double
      public var lon: Double
   }
}

extension String {
   var internetDate: Date {
      get throws {
         let f = DateFormatter()
         f.dateFormat = "yyyy-MM-dd HH:mmZ"
         if let date = f.date(from: self) {
            return date
         }
         return Date()
      }
   }
}
