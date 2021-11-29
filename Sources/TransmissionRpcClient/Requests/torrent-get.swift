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
    self.fields = Self.allTorrentFields
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
  ) async throws -> TransmissionResponse<GetTorrentResponseArguments<CustomTorrent>> {
    try await rpc(method: .getTorrent, tag: tag, arguments: arguments)
  }

  func getFullTorrent(
    ids: TransmissionIdsRequestParameter,
    tag: TransmissionRequestTag? = nil
  ) async throws -> TransmissionResponse<GetFullTorrentResponseArguments> {
    try await rpc(method: .getTorrent, tag: tag, arguments: GetFullTorrentRequestArguments(ids: ids))
  }
}

private extension GetFullTorrentRequestArguments {
  static var allTorrentFields: [String] {
    [
      "name",
      "hashString",
      "id",
      "activityDate",
      "addedDate",
      "bandwidthPriority",
      "comment",
      "corruptEver",
      "creator",
      "dateCreated",
      "desiredAvailable",
      "doneDate",
      "downloadDir",
      "downloadedEver",
      "downloadLimit",
      "downloadLimited",
      "editDate",
      "error",
      "errorString",
      "eta",
      "etaIdle",
      "files",
      "fileStats",
      "haveUnchecked",
      "haveValid",
      "honorsSessionLimits",
      "isFinished",
      "isPrivate",
      "isStalled",
      "labels",
      "leftUntilDone",
      "magnetLink",
      "manualAnnounceTime",
      "maxConnectedPeers",
      "metadataPercentComplete",
      "peer-limit",
      "peers",
      "peersConnected",
      "peersFrom",
      "peersGettingFromUs",
      "peersSendingToUs",
      "percentDone",
      "pieces",
      "pieceCount",
      "pieceSize",
      "priorities",
      "queuePosition",
      "rateDownload",
      "rateUpload",
      "recheckProgress",
      "secondsDownloading",
      "secondsSeeding",
      "seedIdleLimit",
      "seedIdleMode",
      "seedRatioLimit",
      "seedRatioMode",
      "sizeWhenDone",
      "startDate",
      "status",
      "trackers",
      "trackerStats",
      "totalSize",
      "torrentFile",
      "uploadedEver",
      "uploadLimit",
      "uploadLimited",
      "uploadRatio",
      "wanted",
      "webseeds",
      "webseedsSendingToUs",
    ]
  }
}
