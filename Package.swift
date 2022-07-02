// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StrandedModels",
    platforms: [.iOS(.v13), .macOS(.v12)],
    products: [
        .library(name: "StrandedModels", targets: ["StrandedModels"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "StrandedModels",
            dependencies: [
                
            ],
            exclude: [
                "Resources/flight_information.json"
            ]
        ),
    ]
)
