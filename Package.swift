// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "stranded-models",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "StrandedModels", targets: ["StrandedModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/fluent-kit", from: "1.32.0"),
    ],
    targets: [
        .target(
            name: "StrandedModels",
            dependencies: [
                .product(name: "FluentKit", package: "fluent-kit"),
            ],
            exclude: [
                "Resources/flight_information.json"
            ]
        ),
    ]
)
