//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 9/12/21.
//

import Foundation

public struct UserRequest: Codable {
    var id: UUID?
    let apiToken: String?
    var name: String?
    var email: String?
    var deviceToken: String?
    var profileImage: Data?
    var subscriptionId: UUID?
}

public typealias UserResponse = UserRequest

public struct SubscriptionRequest: Codable {
    var airportId: UUID
    var userId: UUID
    var departureDate: Date
    var gate: String?
    var terminal: String?
}

public struct FlightInfoResponse: Codable {
    var number: String?
    var status: String?
    var iataDeparture: String?
    var iataArrival: String?
    var departureAirportName: String?
    var departureLatitude: Double?
    var departureLongitude: Double?
    var departureCountry: String?
    var departureScheduledTime: Date?
    var departureGate: String?
    var departureTerminal: String?
    var arrivalAirportName: String?
    var arrivalLatitude: Double?
    var arrivalLongitude: Double?
    var arrivalCountry: String?
    var arrivalScheduledTime: Date?
    var arrivalGate: String?
    var arrivalTerminal: String?
}

public struct FlightInformation: Codable {
    var departure: FlightInfo
    var arrival: FlightInfo
    var lastUpdatedUtc: String
    var number: String
    var status: String
    var airline: Airline
    
    struct Airline: Codable {
        var name: String
    }
    
    struct FlightInfo: Codable {
        var airport: Airport
        var scheduledTimeLocal: Date?
        var actualTimeLocal: Date?
        var scheduledTimeUtc: Date?
        var actualTimeUtc: Date?
        var terminal: String
        var gate: String
    }

    struct Airport: Codable {
        var icao: String
        var iata: String
        var name: String
        var shortName: String
        var municipalityName: String
    }
    
    struct Location: Codable {
        var lat: Double
        var lon: Double
    }
}
