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

/// This is domain transfer object between third-party -> strandedAPI -> iOS -> strandedAPI
public struct FlightInformation: Codable, Equatable {
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
