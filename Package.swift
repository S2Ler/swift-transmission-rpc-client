// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "swift-transmission-rpc-client",
  platforms: [
      .macOS(.v12),
      .iOS(.v15),
      .tvOS(.v15),
  ],
  products: [
    .library(
      name: "TransmissionRpcClient",
      targets: ["TransmissionRpcClient"]),
    .executable(name: "ClientPlayground",
                targets: ["ClientPlayground"])
  ],
  dependencies: [
    .package(url: "https://github.com/diejmon/Networker.git", .branch("master"))
  ],
  targets: [
    .target(
      name: "TransmissionRpcClient",
      dependencies: ["Networker"]),
    .executableTarget(
      name: "ClientPlayground",
      dependencies: ["TransmissionRpcClient"]),
  ]
)
