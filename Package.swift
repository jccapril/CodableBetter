// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableBetter",
    products: [
        .library(name: "CodableBetter", targets: ["CodableBetter"]),
    ],
    targets: [
        .target(name: "CodableBetter", path: "Sources"),
        .testTarget(name: "CodableBetterTests", dependencies: ["CodableBetter"], path: "Tests"),
    ]
)
