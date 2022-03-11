// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorites",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Favorites",
            targets: ["CoinModularFavorites"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
    ],
    targets: [
        .target(
            name: "CoinModularFavorites",
            dependencies: ["Commons"]),
        .testTarget(
            name: "CoinModularFavoritesTests",
            dependencies: ["CoinModularFavorites"]),
    ]
)
