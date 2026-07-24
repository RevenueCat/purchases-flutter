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
        .package(url: "https://github.com/RevenueCat/purchases-hybrid-common.git", exact: "18.23.0"),
        .package(url: "https://github.com/RevenueCat/purchases-ios-spm", exact: "5.81.2")
    ],
    targets: [
        .target(
            name: "PurchasesFlutterSwiftSupport",
            dependencies: [
                .product(name: "RevenueCat", package: "purchases-ios-spm")
            ],
            path: "Sources/purchases_flutter",
            exclude: [
                "Assets",
                "PurchasesFlutterPlugin.m",
                "include"
            ],
            sources: [
                "PurchasesFlutterDangerousSettingsFactory.swift"
            ]
        ),
        .target(
            name: "purchases_flutter",
            dependencies: [
                .target(name: "PurchasesFlutterSwiftSupport"),
                .product(name: "PurchasesHybridCommon", package: "purchases-hybrid-common")
            ],
            exclude: [
                "PurchasesFlutterDangerousSettingsFactory.swift"
            ],
            publicHeadersPath: "include/purchases_flutter"
        )
    ]
)
