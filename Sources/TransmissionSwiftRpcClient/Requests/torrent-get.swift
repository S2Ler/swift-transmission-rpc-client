import Foundation
import Combine

public struct GetTorrentRequestArguments: Encodable {
  public let ids: TransmissionIdsRequestParameter?
  public let fields: [String]
  internal let format: TransmissionResponseTorrentsFormat?

  public init(
    ids: TransmissionIdsRequestParameter?,
    fields: [String]
  ) {
    self.ids = ids
    self.fields = fields
    self.format = .objects
  }
}

private struct GetFullTorrentRequestArguments: Encodable {
  let ids: TransmissionIdsRequestParameter
  let fields: [String]
  let format: TransmissionResponseTorrentsFormat?

  init(
    ids: TransmissionIdsRequestParameter
  ) {
    self.ids = ids
    self.fields = ["name", "hashString", "id", "activityDate"]
    self.format = .objects
  }
}

public struct GetFullTorrentResponseArguments: Decodable {
  public let torrents: [Torrent]
}

public struct GetTorrentResponseArguments<CustomTorrent: Decodable>: Decodable {
  public let torrents: [CustomTorrent]
}

public extension TransmissionSwiftRpcClient {
  func getTorrent<CustomTorrent: Decodable> (
    _ arguments: GetTorrentRequestArguments,
    tag: TransmissionRequestTag? = nil
  ) -> AnyPublisher<TransmissionResponse<GetTorrentResponseArguments<CustomTorrent>>, Error> {
    rpc(method: .getTorrent, tag: tag, arguments: arguments)
  }

  func getFullTorrent(
    ids: TransmissionIdsRequestParameter,
    tag: TransmissionRequestTag? = nil
  ) -> AnyPublisher<TransmissionResponse<GetFullTorrentResponseArguments>, Error> {
    rpc(method: .getTorrent, tag: tag, arguments: GetFullTorrentRequestArguments(ids: ids))
  }
}
