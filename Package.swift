// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AlertToast",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "AlertToast",
      targets: ["AlertToast"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-format", .upToNextMajor(from: "508.0.1")),
  ],
  targets: [
    .target(
      name: "AlertToast",
      dependencies: []
    ),
    .testTarget(
      name: "AlertToastTests",
      dependencies: ["AlertToast"]
    ),
  ]
)
