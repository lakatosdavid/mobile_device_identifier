// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mobile_device_identifier",
    platforms: [
        .iOS("11.0")
    ],
    products: [
        .library(name: "mobile-device-identifier", targets: ["mobile_device_identifier"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "mobile_device_identifier",
            path: "Sources/mobile_device_identifier",
            exclude: [
                "MobileDeviceIdentifierPlugin.h",
                "MobileDeviceIdentifierPlugin.m"
            ]
        )
    ]
)
