import Foundation
import Networker

internal struct TransmissionResponseDecoder: ResponseDecoder {
  static func decode<T>(
    _ type: T.Type,
    data: Data?,
    response: URLResponse?,
    error: Error?
  ) -> Result<T, TransmissionError> where T : Decodable {
    do {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970
      guard let data = data else {
        return .failure(.transportError(URLError.init(.networkConnectionLost)))
      }
      let decodedValue = try decoder.decode(T.self, from: data)
      return .success(decodedValue)
    }
    catch let error {
      return .failure(.decodingError(error))
    }
  }
}

