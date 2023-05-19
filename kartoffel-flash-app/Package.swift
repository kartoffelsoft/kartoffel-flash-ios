// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "kartoffel-flash-app",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AppRootFeature",
            targets: ["AppRootFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "0.50.0"),
    ],
    targets: [
        .target(
            name: "AppRootFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/AppRootFeature"
        ),
        
        .testTarget(
            name: "AppRootFeatureTests",
            dependencies: [
                "AppRootFeature"
            ]
        ),
    ]
)
