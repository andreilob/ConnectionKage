// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConnectionKage",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "ConnectionKage",
            targets: ["ConnectionKage"]),
    ],
    targets: [
        .target(
            name: "ConnectionKage"),
        .testTarget(
            name: "ConnectionKageTests",
            dependencies: ["ConnectionKage"]
        ),
    ]
)
