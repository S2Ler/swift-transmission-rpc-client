public enum TransmissionError: Swift.Error {
  case transportError(Swift.Error)
  case decodingError(Swift.Error)
}
