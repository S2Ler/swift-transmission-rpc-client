import Foundation
import Networker

internal struct TransmissionResponseDecoder: ResponseDecoder {
    static func decode<T: Decodable>(_ type: T.Type, result: Result<(Data, URLResponse), Error>) -> Result<T, Error> {
    do {
      switch result {
      case .success((let data, let response)):
        if let httpResponse = response as? HTTPURLResponse,
          (httpResponse.statusCode < 200 || httpResponse.statusCode > 299) {
          return .failure(TransmissionError.statusCodeError(httpResponse))
        }
        let decoder = TransmissionJSONDecoder()
        let decodedValue = try decoder.decode(T.self, from: data)
        return .success(decodedValue)
      case .failure(let error):
        return .failure(TransmissionError.transportError(error))
      }
    }
    catch let error {
      return .failure(TransmissionError.decodingError(error))
    }
  }
}

