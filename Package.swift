// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThenMoya",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .watchOS(.v4),
        .tvOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ThenMoya",
            targets: ["ThenMoya"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ghostcrying/Moya.git", .upToNextMajor(from: "1.0.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ThenMoya",
            dependencies: [
                .product(name: "Moya", package: "Moya"),
            ],
            path: "Sources"
        ),
    ]
)
