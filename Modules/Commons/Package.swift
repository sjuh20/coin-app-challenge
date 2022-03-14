// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Commons",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Commons",
            targets: ["CommonsProtocols", "CommonsModel", "CommonsData"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CommonsProtocols",
            dependencies: []),
        .testTarget(
            name: "CommonsProtocolsTests",
            dependencies: ["CommonsProtocols"]),
        .target(
            name: "CommonsModel",
            dependencies: []),
        .testTarget(
            name: "CommonsModelTests",
            dependencies: ["CommonsModel"]),
        .target(
            name: "CommonsData",
            dependencies: []),
        .testTarget(
            name: "CommonsDataTests",
            dependencies: ["CommonsData"]),
    ]
)
