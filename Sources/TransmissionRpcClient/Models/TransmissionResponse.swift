public struct TransmissionResponse<Arguments: Decodable>: Decodable {
  public let result: Result<Void, TransmissionResponseError>
  public let arguments: Arguments?
  public let tag: TransmissionRequestTag?

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let rawResult = try container.decode(String.self, forKey: .result)
    switch rawResult {
    case "success":
      self.result = .success(())
    default:
      self.result = .failure(.init(description: rawResult))
    }

    self.tag = try container.decodeIfPresent(TransmissionRequestTag.self, forKey: .tag)
    self.arguments = try container.decodeIfPresent(Arguments.self, forKey: .arguments)
  }

  private enum CodingKeys: String, CodingKey {
    case result
    case tag
    case arguments
  }
}
