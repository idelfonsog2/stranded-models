//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 9/12/21.
//

import Foundation

struct UserRequest: Codable {
    var id: UUID?
    let apiToken: String?
    var name: String?
    var email: String?
    var deviceToken: String?
    var profileImage: Data?
    var subscriptionId: UUID?
}

typealias UserResponse = UserRequest

struct SubscriptionRequest: Codable {
    var airportId: UUID
    var userId: UUID
    var departureDate: Date
    var gate: String?
    var terminal: String?
}

struct FlightInfoResponse: Codable {
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
