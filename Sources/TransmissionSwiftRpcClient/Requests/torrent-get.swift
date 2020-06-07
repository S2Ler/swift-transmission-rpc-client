import Foundation
import Combine

public struct GetTorrentRequestArguments: Encodable {
  public let ids: TransmissionIdsRequestParameter?
  public let fields: [String]
  public let format: TransmissionResponseTorrentsFormat?

  public init(
    ids: TransmissionIdsRequestParameter?,
    fields: [String],
    format: TransmissionResponseTorrentsFormat?
  ) {
    self.ids = ids
    self.fields = fields
    self.format = format
  }
}

public struct GetTorrentResponseArguments: Decodable {
  public let torrents: [Torrent]
}

public extension TransmissionSwiftRpcClient {
  func getTorrent(
    _ arguments: GetTorrentRequestArguments,
    tag: TransmissionRequestTag? = nil
  ) -> AnyPublisher<TransmissionResponse<GetTorrentResponseArguments>, Error> {
    rpc(method: .getTorrent, tag: tag, arguments: arguments)
  }
}
