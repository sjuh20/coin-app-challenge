// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoinDetail",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CoinDetail",
            targets: ["CoinModularCoinDetail"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
    ],
    targets: [
        .target(
            name: "CoinModularCoinDetail",
            dependencies: ["Commons"]),
        .testTarget(
            name: "CoinModularCoinDetailTests",
            dependencies: ["CoinModularCoinDetail"]),
    ]
)
