import Foundation

@propertyWrapper
public struct DecodeArrayOfNumbersAsBools: Decodable {
  public let wrappedValue: [Bool]

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode([Int].self)
    wrappedValue = value.map { $0 != 0 }
  }
}

extension DecodeArrayOfNumbersAsBools: CustomStringConvertible {
  public var description: String {
    "\(wrappedValue)"
  }
}
