import Foundation

public struct Torrent: Decodable {
  public let id: TorrentId
  public let name: String
  public let hash: TorrentHash
  public let activityDate: Date
}
