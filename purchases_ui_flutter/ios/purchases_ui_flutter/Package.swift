// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "purchases_ui_flutter",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "purchases-ui-flutter", targets: ["purchases_ui_flutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/RevenueCat/purchases-hybrid-common.git", exact: "17.22.0-alphaaidl01")
    ],
    targets: [
        .target(
            name: "purchases_ui_flutter",
            dependencies: [
                .product(name: "PurchasesHybridCommonUI", package: "purchases-hybrid-common")
            ]
        )
    ]
)
