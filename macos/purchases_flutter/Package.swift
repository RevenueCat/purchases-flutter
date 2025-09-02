// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "purchases_flutter",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "purchases-flutter", targets: ["purchases_flutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/RevenueCat/purchases-hybrid-common.git", exact: "17.3.0")
    ],
    targets: [
        .target(
            name: "purchases_flutter",
            dependencies: [
                .product(name: "PurchasesHybridCommon", package: "purchases-hybrid-common")
            ],
            publicHeadersPath: "include/purchases_flutter"
        )
    ]
)
