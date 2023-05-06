// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistedPublished",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "PersistedPublished",
            targets: ["PersistedPublished"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PersistedPublished",
            dependencies: []),
        .testTarget(
            name: "PersistedPublishedTests",
            dependencies: ["PersistedPublished"]),
    ])
