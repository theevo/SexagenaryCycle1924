// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SexagenaryCycle1924",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SexagenaryCycle1924",
            targets: ["SexagenaryCycle1924"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SexagenaryCycle1924",
            resources: [
                .copy("Resources/Wikipedia-Sexagenary-cycle.json"),
            ]
        ),
        .testTarget(
            name: "SexagenaryCycle1924Tests",
            dependencies: ["SexagenaryCycle1924"]),
        .target(
            name: "JSONFilePublisher",
            dependencies: ["SexagenaryCycle1924"],
            resources: [
                .copy("Resources/Wikipedia-Sexagenary-cycle.json"),
            ]
        ),
        .testTarget(
            name: "JSONFilePublisherTests",
            dependencies: ["JSONFilePublisher"]),
    ]
)
