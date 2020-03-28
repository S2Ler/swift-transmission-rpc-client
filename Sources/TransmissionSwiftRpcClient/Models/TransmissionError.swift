import Foundation

public enum TransmissionError: Swift.Error {
  case statusCodeError(HTTPURLResponse)
  case transportError(Swift.Error)
  case decodingError(Swift.Error)
}

extension TransmissionError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .statusCodeError(let response):
      return "Status Code Error: \(response)"
    case .transportError(let error):
      return "Transport Error: \(error)"
    case .decodingError(let error):
      return "Decoding Error: \(error)"
    }
  }
}
