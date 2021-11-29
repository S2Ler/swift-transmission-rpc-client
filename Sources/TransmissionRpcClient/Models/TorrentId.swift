import Foundation

public struct TorrentId: Codable, Equatable, Hashable {
  public let rawValue: Int

  public init(from decoder: Decoder) throws {
    rawValue = try decoder.singleValueContainer().decode(Int.self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}

extension TorrentId: CustomStringConvertible {
  public var description: String {
    "TorrentId_\(rawValue)"
  }
}
