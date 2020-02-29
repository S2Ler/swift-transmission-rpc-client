// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "TransmissionSwiftRpcClient",
  platforms: [
      .macOS(.v10_15),
      .iOS(.v13),
      .tvOS(.v13),
  ],
  products: [
    .library(
      name: "TransmissionSwiftRpcClient",
      targets: ["TransmissionSwiftRpcClient"]),
  ],
  dependencies: [
    .package(url: "https://github.com/diejmon/Networker.git", .branch("master"))
  ],
  targets: [
    .target(
      name: "TransmissionSwiftRpcClient",
      dependencies: ["Networker"]),
  ]
)
