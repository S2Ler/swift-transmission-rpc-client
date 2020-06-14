import Foundation

@propertyWrapper
public struct DecodeNumberAsBool: Decodable {
  public let wrappedValue: Bool

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(Int.self)
    if value == 0 {
      wrappedValue = false
    }
    else {
      wrappedValue = true
    }
  }
}

extension DecodeNumberAsBool: CustomStringConvertible {
  public var description: String {
    "\(wrappedValue)"
  }
}

