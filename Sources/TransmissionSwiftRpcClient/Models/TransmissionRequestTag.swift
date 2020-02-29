public struct TransmissionRequestTag: Codable {
  public let rawTag: Int

  public init(rawTag: Int) {
    self.rawTag = rawTag
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.rawTag = try container.decode(Int.self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawTag)
  }
}
