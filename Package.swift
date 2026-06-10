// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "mobile_device_identifier",
    platforms: [.iOS("11.0")],
    products: [
        .library(name: "mobile-device-identifier", targets: ["mobile_device_identifier"])
    ],
    targets: [
        .target(
            name: "mobile_device_identifier",
            path: "ios/Classes",
            publicHeadersPath: "."
        )
    ]
)