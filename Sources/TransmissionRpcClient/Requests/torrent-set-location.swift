import Foundation
import Combine

public struct SetTorrentLocationRequestArguments: Encodable {
  /// Ids of the files to move
  public let ids: TransmissionIdsRequestParameter

  /// If true, move from previous location. Otherwise, search "location" for files
  public let move: Bool

  /// The new torrent location
  public let location: String

  public init(
    ids: TransmissionIdsRequestParameter,
    move: Bool = false,
    location: String
  ) {
    self.ids = ids
    self.move = move
    self.location = location
  }
}

public struct SetTorrentLocationResponseArguments: Decodable {

}

public extension TransmissionSwiftRpcClient {
  func setTorrentLocation(
    _ arguments: SetTorrentLocationRequestArguments,
    tag: TransmissionRequestTag? = nil
  ) async throws -> TransmissionResponse<SetTorrentLocationResponseArguments> {
    try await rpc(method: .setTorrentLocation, tag: tag, arguments: arguments)
  }
}
