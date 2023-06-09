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
            targets: ["AppRootFeature"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths.git", exact: "0.14.1"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "0.50.0"),
    ],
    targets: [
        .target(
            name: "AppRootFeature",
            dependencies: [
                "HomeFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/AppRootFeature"
        ),
        .target(
            name: "BoxFeature",
            dependencies: [
                "StyleGuide",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/BoxFeature"
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                "BoxFeature",
                "StyleGuide",
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/HomeFeature"
        ),
        
        .target(
            name: "StyleGuide",
            resources: [.process("Resources/")]
        ),
        .target(
            name: "UIKitUtils",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        
        .testTarget(
            name: "AppRootFeatureTests",
            dependencies: [
                "AppRootFeature"
            ],
            path: "./Tests/Features/AppRootFeatureTests"
        ),
    ]
)
