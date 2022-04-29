//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 9/12/21.
//

import Foundation

#if swift(>=5.6)
extension SubscriptionResponse: @unchecked Sendable {}
extension SubscriptionResponse.ItemSubscription: @unchecked Sendable {}
extension SubscriptionRequest: @unchecked Sendable {}
extension FlightInformation: @unchecked  Sendable {}
extension Date: @unchecked Sendable {}
extension UUID: @unchecked Sendable {}
extension Data: @unchecked Sendable {}
#endif

public enum APIError: Error, Equatable {
   case signInWithApple
   case malformedURL
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

/// This is domain transfer object between third-party -> strandedAPI -> iOS -> strandedAPI
public struct FlightInformation: Codable, Equatable {
   public static let sampleURL = Bundle.module.url(forResource: "flight_information", withExtension: "json")!
   
   public var departure: FlightInfo
   public var arrival: FlightInfo
   public var lastUpdatedUtc: Date?
   public var number: String
   public var status: String
   public var airline: Airline?
   
   public init(departure: FlightInformation.FlightInfo,
               arrival: FlightInformation.FlightInfo,
               lastUpdatedUtc: Date,
               number: String,
               status: String,
               airline: FlightInformation.Airline?) {
      self.departure = departure
      self.arrival = arrival
      self.lastUpdatedUtc = lastUpdatedUtc
      self.number = number
      self.status = status
      self.airline = airline
   }
   
   enum CodingKeys: String, CodingKey {
      case departure
      case arrival
      case lastUpdatedUtc
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
      if let lastUpdatedUTCString = try values.decodeIfPresent(String.self, forKey: .lastUpdatedUtc) {
         if let value = utcFormatter.date(from: lastUpdatedUTCString) {
            lastUpdatedUtc = value
         }
         
         if let iso8601 = ISO8601DateFormatter().date(from: lastUpdatedUTCString) {
            lastUpdatedUtc = iso8601
         }
      }
      
      number = try values.decode(String.self, forKey: .number)
      status = try values.decode(String.self, forKey: .status)
      airline = try values.decodeIfPresent(Airline.self, forKey: .airline)
   }
   
   public struct Airline: Codable, Equatable {
      public init(name: String) {
         self.name = name
      }
      
      public var name: String
   }
   
   public struct FlightInfo: Codable, Equatable {
      public init(airport: FlightInformation.Airport,
                  scheduledTimeUtc: Date?,
                  scheduledTimeLocal: Date?,
                  terminal: String? = nil,
                  gate: String? = nil) {
         self.airport = airport
         self.scheduledTimeUtc = scheduledTimeUtc
         self.scheduledTimeLocal = scheduledTimeLocal
         self.terminal = terminal
         self.gate = gate
      }
      
      public var airport: Airport
      public var scheduledTimeUtc: Date?
      public var scheduledTimeLocal: Date?
      public var terminal: String?
      public var gate: String?
      
      enum CodingKeys: String, CodingKey {
         case airport
         case scheduledTimeUtc
         case scheduledTimeLocal
         case terminal
         case gate
      }
      
      public init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         let utcAeroboxDateFormatter = DateFormatter()
         utcAeroboxDateFormatter.dateFormat = "yyyy-MM-dd HH:mm'Z'"

         let localAeroBoxDateFormatter = DateFormatter()
         localAeroBoxDateFormatter.dateFormat = "yyyy-MM-dd HH:mmZ"
         
         /// ScheduledTimeUTC Date + String
         if let scheduledTimeUTCString = try values.decodeIfPresent(String.self, forKey: .scheduledTimeUtc) {
            if let value = utcAeroboxDateFormatter.date(from: scheduledTimeUTCString) {
               scheduledTimeUtc = value
            }
            
            if let iso8601 = ISO8601DateFormatter().date(from: scheduledTimeUTCString) {
               scheduledTimeUtc = iso8601
            }
         }
         
         /// scheduledTimeLocal Date + String
         if let scheduledTimeLocalString = try values.decodeIfPresent(String.self, forKey: .scheduledTimeLocal) {
            if let value = localAeroBoxDateFormatter.date(from: scheduledTimeLocalString) {
               scheduledTimeLocal = value
            }
            
            if let iso8601 = ISO8601DateFormatter().date(from: scheduledTimeLocalString) {
               scheduledTimeLocal = iso8601
            }
         }
         
         airport = try values.decode(Airport.self, forKey: .airport)
         terminal = try values.decodeIfPresent(String.self, forKey: .terminal)
         gate = try values.decodeIfPresent(String.self, forKey: .gate)
      }
   }
   
   public struct Airport: Codable, Equatable {
      public var id: UUID? // TODO: This is the ID from the STRANDED API MODEL
      public var icao: String?
      public var iata: String?
      public var name: String
      public var shortName: String?
      public var municipalityName: String?
      public var location: Location?
      
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
   }
   
   public struct Location: Codable, Equatable {
      public var lat: Double
      public var lon: Double
      public init(lat: Double, lon: Double) {
         self.lat = lat
         self.lon = lon
      }
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

extension FlightInformation {
   public static func sample() -> FlightInformation? {
       do {
           let data = try Data(contentsOf: FlightInformation.sampleURL)
           return try JSONDecoder().decode([FlightInformation].self, from: data).first!
       } catch {
           return nil
       }
   }
}
