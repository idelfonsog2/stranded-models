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
   public init(airportId: UUID, userId: UUID, departureDate: Date?, gate: String? = nil, terminal: String? = nil, profileImage: Data? = nil) {
      self.airportId = airportId
      self.departureDate = departureDate
      self.gate = gate
      self.terminal = terminal
      self.profileImage = profileImage
   }
   
   public var airportId: UUID
   public var departureDate: Date?
   public var gate: String?
   public var terminal: String?
   public var profileImage: Data?
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
      public init(id: UUID?, name: String? = nil, departureDate: Date?, gate: String? = nil, terminal: String? = nil, profileImage: Data? = nil) {
         self.id = id
         self.name = name
         self.departureDate = departureDate
         self.gate = gate
         self.terminal = terminal
         self.profileImage = profileImage
      }
      
      public var id: UUID?
      public var name: String?
      public var departureDate: Date?
      public var gate: String?
      public var terminal: String?
      public var profileImage: Data?
   }
}

extension SubscriptionResponse.ItemSubscription: Hashable, Identifiable { }

/// This is domain transfer object between third-party -> strandedAPI -> ios client
public struct FlightInformation: Codable {
   public static let sampleURL = Bundle.module.url(forResource: "flight_information", withExtension: "json")!
   
   public init(departure: FlightInformation.FlightInfo,
               arrival: FlightInformation.FlightInfo,
               lastUpdatedUTC: Date,
               number: String,
               status: String,
               airline: FlightInformation.Airline?) {
      self.departure = departure
      self.arrival = arrival
      self.lastUpdatedUTC = lastUpdatedUTC
      self.number = number
      self.status = status
      self.airline = airline
   }
   
   enum CodingKeys: String, CodingKey {
      case departure
      case arrival
      case lastUpdatedUTC
      case number
      case status
      case airline
   }
   
   public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      departure = try values.decode(FlightInformation.FlightInfo.self, forKey: .departure)
      arrival = try values.decode(FlightInformation.FlightInfo.self, forKey: .arrival)
      
      let utcFormatter = DateFormatter() //"2021-10-28 17:15Z"
      utcFormatter.dateFormat = "yyyy-MM-dd HH:mm'Z'"
      let lastUpdatedUTCString = try values.decode(String.self, forKey: .lastUpdatedUTC)
      lastUpdatedUTC = utcFormatter.date(from: lastUpdatedUTCString)
      
      number = try values.decode(String.self, forKey: .number)
      status = try values.decode(String.self, forKey: .status)
      airline = try values.decode(Airline.self, forKey: .airline)
   }
   
   public var departure: FlightInfo
   public var arrival: FlightInfo
   public var lastUpdatedUTC: Date?
   public var number: String
   public var status: String
   public var airline: Airline?
   
   public struct Airline: Codable {
      public init(name: String) {
         self.name = name
      }
      
      public var name: String
   }
   
   public struct FlightInfo: Codable {
      public init(airport: FlightInformation.Airport,
                  scheduledTimeUTC: Date?,
                  scheduledTimeLocal: Date?,
                  terminal: String? = nil,
                  gate: String? = nil) {
         self.airport = airport
         self.scheduledTimeUTC = scheduledTimeUTC
         self.scheduledTimeLocal = scheduledTimeLocal
         self.terminal = terminal
         self.gate = gate
      }
      
      public var airport: Airport
      public var scheduledTimeUTC: Date?
      public var scheduledTimeLocal: Date?
      public var terminal: String?
      public var gate: String?
      
      enum CodingKeys: String, CodingKey {
         case airport
         case scheduledTimeUTC
         case scheduledTimeLocal
         case terminal
         case gate
      }
      
      public init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         let utcFormatter = DateFormatter() //"2021-10-28 17:15Z"
         utcFormatter.dateFormat = "yyyy-MM-dd HH:mm'Z'"
         let otherFormatter = DateFormatter() //"2021-10-28 12:15-05:00"
         otherFormatter.dateFormat = "yyyy-MM-dd HH:mmZ"
         
         if let scheduledTimeUTCString = try values.decode(String?.self, forKey: .scheduledTimeUTC) {
            scheduledTimeUTC = utcFormatter.date(from: scheduledTimeUTCString)
         }
         
         if let scheduledTimeLocalString = try values.decode(String?.self, forKey: .scheduledTimeLocal) {
            scheduledTimeLocal = otherFormatter.date(from: scheduledTimeLocalString)
         }
         
         airport = try values.decode(Airport.self, forKey: .airport)
         terminal = try values.decode(String.self, forKey: .terminal)
         gate = try values.decode(String.self, forKey: .gate)
      }
   }
   
   public struct Airport: Codable {
      public init(id: UUID? = nil, icao: String?, iata: String?, name: String, shortName: String?,
                  municipalityName: String?, location: Location?) {
         self.id = id
         self.icao = icao
         self.iata = iata
         self.name = name
         self.shortName = shortName
         self.municipalityName = municipalityName
         self.location = location
      }
      
      public var id: UUID? // TODO: This is the ID from the STRANDED API MODEL
      public var icao: String?
      public var iata: String?
      public var name: String
      public var shortName: String?
      public var municipalityName: String?
      public var location: Location?
      
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
