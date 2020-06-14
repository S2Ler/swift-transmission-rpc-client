import Foundation

internal final class TransmissionJSONDecoder: JSONDecoder {
  private struct CustomCodingKey: CodingKey {
    var stringValue: String

    init?(stringValue: String) {
      self.stringValue = stringValue
    }

    var intValue: Int? {
      return nil
    }

    init?(intValue: Int) {
      return nil
    }
  }

  override init() {
    super.init()
    dateDecodingStrategy = .secondsSince1970
    keyDecodingStrategy = .custom({ (keys) -> CodingKey in
      let lastKey = keys.last!
      if lastKey.intValue != nil {
        return lastKey // It's an array key, we don't need to change anything
      }

      switch lastKey.stringValue {
      case "hashString":
        return CustomCodingKey(stringValue: "hash")!
      case "peer-limit":
        return CustomCodingKey(stringValue: "peerLimit")!
      default:
        return lastKey
      }
    })
  }
}
