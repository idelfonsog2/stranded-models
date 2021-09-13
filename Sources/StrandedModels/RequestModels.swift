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

struct FlightInformation: Codable {
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

//
//[
//    {
//        "greatCircleDistance": {
//            "meter": 2705584.3,
//            "km": 2705.584,
//            "mile": 1681.172,
//            "nm": 1460.899,
//            "feet": 8876588.9
//        },
//        "departure": {
//            "airport": {
//                "icao": "LEMD",
//                "iata": "MAD",
//                "name": "Madrid, Adolfo Suárez Madrid–Barajas",
//                "shortName": "Adolfo Suárez –Barajas",
//                "municipalityName": "Madrid",
//                "location": {
//                    "lat": 40.4936,
//                    "lon": -3.56676
//                },
//                "countryCode": "ES"
//            },
//            "scheduledTimeLocal": "2021-09-07 18:10+02:00",
//            "actualTimeLocal": "2021-09-07 18:06+02:00",
//            "scheduledTimeUtc": "2021-09-07 16:10Z",
//            "actualTimeUtc": "2021-09-07 16:06Z",
//            "terminal": "1",
//            "checkInDesk": "308-312",
//            "gate": "B30",
//            "quality": [
//                "Basic",
//                "Live"
//            ]
//        },
//        "arrival": {
//            "airport": {
//                "icao": "LTFM",
//                "iata": "IST",
//                "name": "Istanbul",
//                "shortName": "Istanbul",
//                "municipalityName": "Istanbul",
//                "location": {
//                    "lat": 41.2752762,
//                    "lon": 28.7519436
//                },
//                "countryCode": "TR"
//            },
//            "scheduledTimeLocal": "2021-09-07 23:25+03:00",
//            "scheduledTimeUtc": "2021-09-07 20:25Z",
//            "quality": [
//                "Basic"
//            ]
//        },
//        "lastUpdatedUtc": "2021-09-07 16:29Z",
//        "number": "TK 1860",
//        "status": "Departed",
//        "codeshareStatus": "Unknown",
//        "isCargo": false,
//        "aircraft": {
//            "model": "Airbus A321"
//        },
//        "airline": {
//            "name": "Turkish"
//        }
//    }
//]
