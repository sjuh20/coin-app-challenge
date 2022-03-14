// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Home",
            targets: ["CoinModularHome"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
        .package(path: "../Coins"),
        .package(path: "../Favorites"),
    ],
    targets: [
        .target(
            name: "CoinModularHome",
            dependencies: ["Commons", "Coins", "Favorites"]),
        .testTarget(
            name: "CoinModularHomeTests",
            dependencies: ["CoinModularHome"]),
    ]
)
