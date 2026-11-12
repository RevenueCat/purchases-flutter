// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "purchases_flutter",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "purchases-flutter", targets: ["purchases_flutter"])
    ],
    dependencies: [
        // TODO: before merging 12.0-dev into main, replace this development reference with the published PHC 21 version. (SDK-4601)
        .package(url: "https://github.com/RevenueCat/purchases-hybrid-common.git", branch: "21.0-dev")
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
