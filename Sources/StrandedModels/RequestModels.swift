//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 9/12/21.
//

import Foundation

public struct UserRequest: Codable {
    public var id: UUID?
    public let apiToken: String?
    public var name: String?
    public var email: String?
    public var deviceToken: String?
    public var profileImage: Data?
    public var subscriptionId: UUID?
}

public typealias UserResponse = UserRequest

public struct SubscriptionRequest: Codable {
    public var airportId: UUID
    public var userId: UUID
    public var departureDate: Date
    public var gate: String?
    public var terminal: String?
}

public struct FlightInfoResponse: Codable {
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
