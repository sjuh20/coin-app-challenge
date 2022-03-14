// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinator",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Coordinator",
            targets: ["CoinModularCoordinator"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
        .package(path: "../Home"),
        .package(path: "../Coins"),
        .package(path: "../Favorites"),
        .package(path: "../CoinDetail"),
    ],
    targets: [
        .target(
            name: "CoinModularCoordinator",
            dependencies: ["Commons", "Home", "Coins", "Favorites", "CoinDetail"]),
        .testTarget(
            name: "CoinModularCoordinatorTests",
            dependencies: ["CoinModularCoordinator"]),
    ]
)
