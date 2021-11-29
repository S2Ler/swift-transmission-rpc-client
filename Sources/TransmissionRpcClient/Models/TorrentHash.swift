import Foundation

public struct TorrentHash: Codable, Equatable, Hashable {
  public let rawValue: String

  public init(from decoder: Decoder) throws {
    rawValue = try decoder.singleValueContainer().decode(String.self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}

extension TorrentHash: CustomStringConvertible {
  public var description: String {
    "TorrentHash_\(rawValue)"
  }
}
