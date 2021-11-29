internal struct TransmissionEmptyResponse: Decodable {
  let result: Result<Void, TransmissionResponseError>
  let tag: TransmissionRequestTag?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let rawResult = try container.decode(String.self, forKey: .result)
    switch rawResult {
    case "success":
      self.result = .success(())
    default:
      self.result = .failure(.init(description: rawResult))
    }

    self.tag = try container.decode(TransmissionRequestTag.self, forKey: .tag)
  }

  private enum CodingKeys: String, CodingKey {
    case result
    case tag
  }
}
