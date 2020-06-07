import Foundation
import Combine

public struct AddTorrentRequestArguments: Encodable {
  public let metainfo: String
  public let isPaused: Bool
  public let downloadFolderUrl: URL

  public init(content: Data, isPaused: Bool, downloadFolderUrl: URL) {
    self.metainfo = content.base64EncodedString()
    self.isPaused = isPaused
    self.downloadFolderUrl = downloadFolderUrl
  }
}

public struct AddTorrentResponseArguments: Decodable {
  private struct TorrentAddedInfo: Decodable {
    let hash: TorrentHash
    let id: TorrentId
    let name: String
  }

  private let torrentAddedInfo: TorrentAddedInfo?
  private let torrentDuplicateInfo: TorrentAddedInfo?

  /// A convenient property which returns non-optional `TorrentAddedInfo`.
  /// - note: `torrent-add` response can have either `torrentAddedInfo` value or `torrentDuplicateInfo`.
  private var unwrappedTorrentInfo: TorrentAddedInfo {
    if let torrentAddedInfo = torrentAddedInfo {
      return torrentAddedInfo
    }
    else if let torrentDuplicateInfo = torrentDuplicateInfo {
      return torrentDuplicateInfo
    }
    else {
      preconditionFailure("Contract error. Successful response should have either `torrentAddedInfo` or `torrentDuplicateInfo`")
    }
  }

  private enum CodingKeys: String, CodingKey {
    case torrentAddedInfo = "torrent-added"
    case torrentDuplicateInfo = "torrent-duplicate"
  }

  /// Indicates if added torrent already exists in the list of torrents
  public var isDuplicate: Bool { torrentDuplicateInfo != nil }

  /// Added torrent hash
  public var hash: TorrentHash { unwrappedTorrentInfo.hash }

  /// Added torrent id
  public var id: TorrentId { unwrappedTorrentInfo.id }

  /// Name of the added torrent
  public var name: String { unwrappedTorrentInfo.name }
}

public extension TransmissionSwiftRpcClient {
  func addTorrent(
    _ arguments: AddTorrentRequestArguments,
    tag: TransmissionRequestTag? = nil
  ) -> AnyPublisher<TransmissionResponse<AddTorrentResponseArguments>, Error> {
    rpc(method: .addTorrent, tag: tag, arguments: arguments)
  }
}
