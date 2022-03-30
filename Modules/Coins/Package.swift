// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coins",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Coins",
            targets: ["CoinModularCoins"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
        .package(path: "../CoinDetail")
    ],
    targets: [
        .target(
            name: "CoinModularCoins",
            dependencies: ["Commons", "CoinDetail"]),
        .testTarget(
            name: "CoinModularCoinsTests",
            dependencies: ["CoinModularCoins"]),
    ]
)
