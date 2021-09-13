//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 9/12/21.
//

import Foundation

/// This is domain transfer object
public struct UserRequest: Codable {
    
    public var id: UUID?
    public let apiToken: String?
    public var name: String?
    public var email: String?
    public var deviceToken: String?
    public var profileImage: Data?
    public var subscriptionId: UUID?
    
    public init(id: UUID? = nil, apiToken: String?, name: String? = nil, email: String? = nil, deviceToken: String? = nil, profileImage: Data? = nil, subscriptionId: UUID? = nil) {
        self.id = id
        self.apiToken = apiToken
        self.name = name
        self.email = email
        self.deviceToken = deviceToken
        self.profileImage = profileImage
        self.subscriptionId = subscriptionId
    }
}

public typealias UserResponse = UserRequest

/// This is domain transfer object
public struct SubscriptionRequest: Codable {
    public init(id: UUID?, airportId: UUID, userId: UUID, departureDate: Date, gate: String? = nil, terminal: String? = nil) {
        self.id = id
        self.airportId = airportId
        self.userId = userId
        self.departureDate = departureDate
        self.gate = gate
        self.terminal = terminal
    }
    
    public let id: UUID?
    public var airportId: UUID
    public var userId: UUID
    public var departureDate: Date
    public var gate: String?
    public var terminal: String?
}

extension SubscriptionRequest: Hashable, Identifiable { }

public typealias SubscriptionResponse = SubscriptionRequest

/// This is a passthrough object
/// deprecate
public struct FlightInfoResponse: Codable {
    public init(number: String? = nil, status: String? = nil, iataDeparture: String? = nil, iataArrival: String? = nil, departureAirportName: String? = nil, departureLatitude: Double? = nil, departureLongitude: Double? = nil, departureCountry: String? = nil, departureScheduledTime: Date? = nil, departureGate: String? = nil, departureTerminal: String? = nil, arrivalAirportName: String? = nil, arrivalLatitude: Double? = nil, arrivalLongitude: Double? = nil, arrivalCountry: String? = nil, arrivalScheduledTime: Date? = nil, arrivalGate: String? = nil, arrivalTerminal: String? = nil) {
        self.number = number
        self.status = status
        self.iataDeparture = iataDeparture
        self.iataArrival = iataArrival
        self.departureAirportName = departureAirportName
        self.departureLatitude = departureLatitude
        self.departureLongitude = departureLongitude
        self.departureCountry = departureCountry
        self.departureScheduledTime = departureScheduledTime
        self.departureGate = departureGate
        self.departureTerminal = departureTerminal
        self.arrivalAirportName = arrivalAirportName
        self.arrivalLatitude = arrivalLatitude
        self.arrivalLongitude = arrivalLongitude
        self.arrivalCountry = arrivalCountry
        self.arrivalScheduledTime = arrivalScheduledTime
        self.arrivalGate = arrivalGate
        self.arrivalTerminal = arrivalTerminal
    }
    
    public var number: String?
    public var status: String?
    public var iataDeparture: String?
    public var iataArrival: String?
    public var departureAirportName: String?
    public var departureLatitude: Double?
    public var departureLongitude: Double?
    public var departureCountry: String?
    public var departureScheduledTime: Date?
    public var departureGate: String?
    public var departureTerminal: String?
    public var arrivalAirportName: String?
    public var arrivalLatitude: Double?
    public var arrivalLongitude: Double?
    public var arrivalCountry: String?
    public var arrivalScheduledTime: Date?
    public var arrivalGate: String?
    public var arrivalTerminal: String?
}

/// This is domain transfer object
public struct FlightInformation: Codable {
    public var departure: FlightInfo
    public var arrival: FlightInfo
    public var lastUpdatedUtc: String
    public var number: String
    public var status: String
    public var airline: Airline
    
    public struct Airline: Codable {
        public var name: String
    }
    
    public struct FlightInfo: Codable {
        public var airport: Airport
        public var scheduledTimeLocal: Date?
        public var actualTimeLocal: Date?
        public var scheduledTimeUtc: Date?
        public var actualTimeUtc: Date?
        public var terminal: String
        public var gate: String
    }

    public struct Airport: Codable {
        public var icao: String
        public var iata: String
        public var name: String
        public var shortName: String
        public var municipalityName: String
    }
    
    public struct Location: Codable {
        public var lat: Double
        public var lon: Double
    }
}
