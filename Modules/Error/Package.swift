// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Error",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Error",
            targets: ["CoinModularError"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
    ],
    targets: [
        .target(
            name: "CoinModularError",
            dependencies: ["Commons"]),
        .testTarget(
            name: "CoinModularErrorTests",
            dependencies: ["CoinModularError"]),
    ]
)
