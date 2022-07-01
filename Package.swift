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
        .package(url: "https://github.com/apple/swift-crypto.git", from: "2.1.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.4.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.2.6"),
    ],
    targets: [
        .target(
            name: "StrandedModels",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Crypto", package: "swift-crypto")
            ],
            exclude: [
                "Resources/flight_information.json"
            ]
        ),
    ]
)
