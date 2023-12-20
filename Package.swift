// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SexagenaryCycle1924",
    products: [
        .library(
            name: "SexagenaryCycle1924",
            targets: ["SexagenaryCycle1924"]),
        .executable(
            name: "jsonPublisher",
            targets: ["JSONFilePublisher"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "SexagenaryCycle1924",
            resources: [
                .copy("Resources/Wikipedia-Sexagenary-cycle.json"),
            ]
        ),
        .testTarget(
            name: "SexagenaryCycle1924Tests",
            dependencies: ["SexagenaryCycle1924"]),
        .executableTarget(
            name: "JSONFilePublisher",
            dependencies: [
                "SexagenaryCycle1924",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .testTarget(
            name: "JSONFilePublisherTests",
            dependencies: ["JSONFilePublisher"]),
    ]
)
